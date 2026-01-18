#!/usr/bin/env python3
"""
Generate HTML index page for GitHub Pages using Jinja2 templates.

This script reads PDF files from the docs directory, categorizes them based on
their original directory location in the repository, and generates an index.html
file using the Jinja2 template.
"""

import re
import subprocess
import sys
from pathlib import Path
from typing import Optional

import yaml
from jinja2 import Environment, FileSystemLoader

# Default category metadata
DEFAULT_CATEGORY_METADATA = {
    "GeneralPhysics": {
        "name": "General Physics",
        "description": "General Physics lecture materials for engineering students",
        "order": 1,
    },
    "Policies": {
        "name": "Policies",
        "description": "Course policies and guidelines",
        "order": 2,
    },
}

# Default metadata for uncategorized resources
DEFAULT_OTHER_METADATA = {
    "name": "Other Resources",
    "description": "Additional materials and resources",
    "order": 99,
}

# File size units for human-readable display
FILE_SIZE_UNITS = ["B", "KB", "MB", "GB", "TB"]


def sanitize_html(html: str) -> str:
    """
    Sanitize HTML to allow only safe tags and attributes.
    Currently only allows <a> tags with href attributes.
    """
    if not html:
        return html
    # Very simple sanitization: only allow <a href="..."> tags
    # Remove all tags except <a>
    result = re.sub(r"<(?!/?a[\s>])[^>]*>", "", html)
    # Ensure href attributes only contain safe URLs (http/https)
    result = re.sub(r'href=["\'](?!https?://)[^"\']*["\']', 'href="#"', result)
    return result


def get_file_size(filepath: Path) -> str:
    """Get human-readable file size."""
    size_bytes = float(filepath.stat().st_size)
    for unit in FILE_SIZE_UNITS[:-1]:  # All units except the last one
        if size_bytes < 1024.0:
            return f"{size_bytes:.1f}{unit}"
        size_bytes /= 1024.0
    return f"{size_bytes:.1f}{FILE_SIZE_UNITS[-1]}"


def is_old_version(filename: str) -> bool:
    """Check if filename represents an old version (contains -v followed by digits)."""
    return bool(re.search(r"-v\d", filename))


def find_original_file_path(filename: str, repo_root: Path) -> Optional[Path]:
    """
    Find the original file path in the repository (outside docs and .git directories).
    Returns the relative path from repo root, or None if not found.
    """
    try:
        for pdf_path in repo_root.glob(f"**/{filename}"):
            try:
                relative = pdf_path.relative_to(repo_root)
                if not str(relative).startswith("docs/") and not str(
                    relative
                ).startswith(".git/"):
                    return relative
            except ValueError:
                continue
        return None
    except Exception as e:
        print(f"Warning: Could not search for original location of {filename}: {e}")
        return None


def build_category_metadata(categories: dict[str, list]) -> dict[str, dict]:
    """
    Build category metadata with display information.
    
    Args:
        categories: Dictionary mapping directory names to file lists
        
    Returns:
        Dictionary mapping directory names to metadata (name, description, order)
    """
    category_metadata = DEFAULT_CATEGORY_METADATA.copy()
    
    # Add metadata for "figs" and "Other" directories (use copies to avoid mutation)
    category_metadata["figs"] = DEFAULT_OTHER_METADATA.copy()
    category_metadata["Other"] = DEFAULT_OTHER_METADATA.copy()
    
    # Add default metadata for any directories not in the predefined mapping
    for directory in categories.keys():
        if directory not in category_metadata:
            category_metadata[directory] = {
                "name": directory,
                "description": f"{directory} materials",
                "order": 50,  # Default order between main categories and "Other"
            }
    
    return category_metadata


def collect_pdf_metadata(
    pdf_files: list[Path], github_repo: str, repo_root: Path
) -> list[dict]:
    """
    Collect metadata for all PDF files.
    
    Caches the original file path lookup to avoid repeated searches.
    
    Args:
        pdf_files: List of PDF file paths
        github_repo: GitHub repository identifier (owner/repo)
        repo_root: Root directory of the repository
        
    Returns:
        List of dictionaries containing file metadata
    """
    all_files = []
    
    for pdf_file in pdf_files:
        filename = pdf_file.name
        
        # Cache the original path to avoid multiple lookups
        original_path = find_original_file_path(filename, repo_root)
        
        all_files.append(
            {
                "filename": filename,
                "size": get_file_size(pdf_file),
                "is_old_version": is_old_version(filename),
                "last_commit_date": _get_last_commit_date_from_path(
                    original_path, repo_root
                ),
                "github_history_url": _build_github_history_url(
                    original_path, filename, github_repo
                ),
                "directory": _get_directory_from_path(original_path),
            }
        )
    
    return all_files


def _get_directory_from_path(original_path: Optional[Path]) -> str:
    """Extract directory category from original file path."""
    if original_path:
        parent_dir = original_path.parent
        if str(parent_dir) != ".":
            return str(parent_dir)
    return "Other"


def _get_last_commit_date_from_path(
    original_path: Optional[Path], repo_root: Path
) -> Optional[str]:
    """Get the last commit date for a file from its path."""
    if not original_path:
        return None
    
    # Validate path to prevent command injection and path traversal
    try:
        resolved_path = original_path.resolve()
        resolved_repo_root = repo_root.resolve()
        
        # Ensure the resolved path is within the repository (Python 3.9+)
        resolved_path.relative_to(resolved_repo_root)
    except (ValueError, OSError) as e:
        print(f"Warning: Path outside repository or invalid: {original_path} ({e})")
        return None
    
    path_str = str(original_path)
    
    try:
        # Use git log to get the last commit date for this file
        result = subprocess.run(
            ["git", "log", "-1", "--format=%ci", "--", path_str],
            cwd=repo_root,
            capture_output=True,
            text=True,
            timeout=5,
        )
        
        if result.returncode == 0 and result.stdout.strip():
            # Parse the date and format it (get just the date part: YYYY-MM-DD)
            date_str = result.stdout.strip().split()[0]
            return date_str
        
        return None
    except Exception as e:
        print(f"Warning: Could not get commit date for {path_str}: {e}")
        return None


def _build_github_history_url(
    original_path: Optional[Path], filename: str, github_repo: str
) -> str:
    """Build GitHub history URL for a file."""
    file_path = str(original_path) if original_path else filename
    return f"https://github.com/{github_repo}/commits/main/{file_path}"


def load_and_sanitize_config(config_file: Path) -> dict:
    """Load configuration file and sanitize HTML content."""
    with open(config_file, "r", encoding="utf-8") as f:
        config = yaml.safe_load(f)
    
    # Sanitize HTML in site section
    if "site" in config:
        for key in ["welcome_message", "footer_text", "license_text"]:
            if key in config["site"]:
                config["site"][key] = sanitize_html(str(config["site"][key]))
    
    return config


def categorize_files(all_files: list[dict]) -> dict[str, list]:
    """
    Categorize files by directory.
    
    Args:
        all_files: List of file metadata dictionaries
        
    Returns:
        Dictionary mapping directory names to lists of files
    """
    categories = {}
    for file in all_files:
        directory = file["directory"]
        if directory not in categories:
            categories[directory] = []
        categories[directory].append(file)
    
    return categories


def main():
    """Main function to generate the index.html file."""
    # Determine paths
    script_dir = Path(__file__).parent
    repo_root = script_dir.parent.parent  # Assuming script is in .github/scripts/
    config_file = repo_root / ".github" / "page-config.yml"
    template_dir = repo_root / ".github" / "templates"
    template_file = "index.html.j2"
    docs_dir = repo_root / "docs"
    output_file = docs_dir / "index.html"

    # Validate required files exist
    if not config_file.exists():
        print(f"Error: Configuration file not found: {config_file}")
        sys.exit(1)

    if not (template_dir / template_file).exists():
        print(f"Error: Template file not found: {template_dir / template_file}")
        sys.exit(1)

    if not docs_dir.exists():
        print(f"Error: Docs directory not found: {docs_dir}")
        sys.exit(1)

    # Load and sanitize configuration
    config = load_and_sanitize_config(config_file)

    # Get all PDF files from docs directory
    pdf_files = list(docs_dir.glob("*.pdf"))
    if not pdf_files:
        print("Warning: No PDF files found in docs directory")
    print(f"Found {len(pdf_files)} PDF files")

    # Get GitHub repository information
    github_repo = config.get("site", {}).get("github_repo", "misho104/LecturePublic")

    # Collect metadata for all files (with caching to avoid repeated lookups)
    all_files = collect_pdf_metadata(pdf_files, github_repo, repo_root)

    # Sort files by name
    all_files.sort(key=lambda x: x["filename"])

    # Categorize files by directory
    categories = categorize_files(all_files)

    # Build category metadata
    category_metadata = build_category_metadata(categories)

    # Sort categories by order
    sorted_categories = sorted(
        categories.items(), key=lambda x: category_metadata[x[0]]["order"]
    )

    # Print summary
    print(f"Processed {len(all_files)} PDF files:")
    for directory, files in sorted(categories.items()):
        print(f"  - {directory}: {len(files)} files")

    # Setup Jinja2 environment and render template
    env = Environment(loader=FileSystemLoader(template_dir))
    template = env.get_template(template_file)

    html_content = template.render(
        config=config,
        sorted_categories=sorted_categories,
        category_metadata=category_metadata,
    )

    # Write output
    with open(output_file, "w", encoding="utf-8") as f:
        f.write(html_content)

    print(f"Successfully generated: {output_file}")


if __name__ == "__main__":
    main()
