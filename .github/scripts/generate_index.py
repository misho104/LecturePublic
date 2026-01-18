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
    for unit in ["B", "KB", "MB", "GB"]:
        if size_bytes < 1024.0:
            return f"{size_bytes:.1f}{unit}"
        size_bytes /= 1024.0
    return f"{size_bytes:.1f}TB"


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


def get_directory_category(filename: str, repo_root: Path) -> str:
    """
    Get the category based on the directory where the file is located.
    Returns the parent directory name, or 'Other' if not found.
    """
    original_path = find_original_file_path(filename, repo_root)
    if original_path:
        # Get the parent directory name
        parent_dir = original_path.parent
        # Check if file is in a subdirectory (not at repo root)
        if str(parent_dir) != ".":
            return str(parent_dir)
    return "Other"


def get_last_commit_date(filename: str, repo_root: Path) -> Optional[str]:
    """
    Get the last commit date for a file using git log.
    Searches for the original file location in the repository.
    Returns formatted date string or None if unavailable.
    """
    try:
        original_path = find_original_file_path(filename, repo_root)
        if not original_path:
            return None

        # Validate path to prevent command injection
        path_str = str(original_path)
        if ".." in path_str or path_str.startswith("/"):
            print(f"Warning: Invalid path detected for {filename}")
            return None

        # Use git log to get the last commit date for this file
        result = subprocess.run(
            ["git", "log", "-1", "--format=%ci", "--", path_str],
            cwd=repo_root,
            capture_output=True,
            text=True,
            timeout=5,
        )

        if result.returncode == 0 and result.stdout.strip():
            # Parse the date and format it
            date_str = result.stdout.strip().split()[
                0
            ]  # Get just the date part (YYYY-MM-DD)
            return date_str

        return None
    except Exception as e:
        print(f"Warning: Could not get commit date for {filename}: {e}")
        return None


def get_github_history_url(filename: str, github_repo: str, repo_root: Path) -> str:
    """
    Build GitHub history URL for a file.
    Searches for the original file location in the repository.
    Format: https://github.com/owner/repo/commits/main/path/to/file.pdf
    """
    original_path = find_original_file_path(filename, repo_root)
    file_path = str(original_path) if original_path else filename
    return f"https://github.com/{github_repo}/commits/main/{file_path}"


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

    # Check if config file exists
    if not config_file.exists():
        print(f"Error: Configuration file not found: {config_file}")
        sys.exit(1)

    # Check if template exists
    if not (template_dir / template_file).exists():
        print(f"Error: Template file not found: {template_dir / template_file}")
        sys.exit(1)

    # Load configuration
    with open(config_file, "r", encoding="utf-8") as f:
        config = yaml.safe_load(f)

    # Sanitize HTML in site section
    if "site" in config:
        for key in ["welcome_message", "footer_text", "license_text"]:
            if key in config["site"]:
                config["site"][key] = sanitize_html(str(config["site"][key]))

    # Get all PDF files from docs directory
    if not docs_dir.exists():
        print(f"Error: Docs directory not found: {docs_dir}")
        sys.exit(1)

    pdf_files = list(docs_dir.glob("*.pdf"))

    if not pdf_files:
        print("Warning: No PDF files found in docs directory")

    print(f"Found {len(pdf_files)} PDF files")

    # Get GitHub repository information
    github_repo = config.get("site", {}).get("github_repo", "misho104/LecturePublic")

    # Build file list with metadata including directory category
    all_files = []
    for pdf_file in pdf_files:
        filename = pdf_file.name
        all_files.append(
            {
                "filename": filename,
                "size": get_file_size(pdf_file),
                "is_old_version": is_old_version(filename),
                "last_commit_date": get_last_commit_date(filename, repo_root),
                "github_history_url": get_github_history_url(
                    filename, github_repo, repo_root
                ),
                "directory": get_directory_category(filename, repo_root),
            }
        )

    # Sort files by name
    all_files.sort(key=lambda x: x["filename"])

    # Categorize files by directory for better template performance
    categories = {}
    for file in all_files:
        directory = file["directory"]
        if directory not in categories:
            categories[directory] = []
        categories[directory].append(file)

    # Define category metadata (display name, description, order)
    # This can be extended for future courses/types

    # Default metadata for "Other" resources
    other_metadata = {
        "name": "Other Resources",
        "description": "Additional materials and resources",
        "order": 99,
    }

    category_metadata = {
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
        "figs": other_metadata,  # figs directory contains license and other resources
        "Other": other_metadata,
    }

    # Add default metadata for any directories not in the mapping
    for directory in categories.keys():
        if directory not in category_metadata:
            category_metadata[directory] = {
                "name": directory,
                "description": f"{directory} materials",
                "order": 50,  # Default order between main categories and "Other"
            }

    # Sort categories by order
    sorted_categories = sorted(
        categories.items(), key=lambda x: category_metadata[x[0]]["order"]
    )

    # Print summary
    print(f"Processed {len(all_files)} PDF files:")
    for directory, files in sorted(categories.items()):
        print(f"  - {directory}: {len(files)} files")

    # Setup Jinja2 environment
    env = Environment(loader=FileSystemLoader(template_dir))
    template = env.get_template(template_file)

    # Render template with categorized files
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
