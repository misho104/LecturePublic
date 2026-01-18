#!/usr/bin/env python3
"""
Generate HTML index page for GitHub Pages using Jinja2 templates.

This script reads PDF files from the docs directory and generates an index.html
file using the Jinja2 template. The template calls list_pdf_data_in_directory()
to get file metadata for specific directories.
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


def get_last_commit_date(original_path: Optional[Path], repo_root: Path) -> Optional[str]:
    """
    Get the last commit date for a file using git log.
    Returns formatted date string or None if unavailable.
    """
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


def get_github_history_url(original_path: Optional[Path], filename: str, github_repo: str) -> str:
    """
    Build GitHub history URL for a file.
    Format: https://github.com/owner/repo/commits/main/path/to/file.pdf
    """
    file_path = str(original_path) if original_path else filename
    return f"https://github.com/{github_repo}/commits/main/{file_path}"


def list_pdf_data_in_directory(
    directory_path: str, docs_dir: Path, repo_root: Path, github_repo: str
) -> list[dict]:
    """
    List PDF files in a specific directory with their metadata.
    
    Args:
        directory_path: Directory name (e.g., "GeneralPhysics") or "." for root
        docs_dir: Path to the docs directory containing PDFs
        repo_root: Path to repository root
        github_repo: GitHub repository identifier (owner/repo)
        
    Returns:
        List of dictionaries containing file metadata for PDFs in the directory
    """
    result = []
    
    # Get all PDF files from docs directory
    all_pdfs = list(docs_dir.glob("*.pdf"))
    
    for pdf_file in all_pdfs:
        filename = pdf_file.name
        
        # Find original location to determine directory
        original_path = find_original_file_path(filename, repo_root)
        
        # Determine if this file belongs to the requested directory
        if original_path:
            file_dir = str(original_path.parent)
            # Match files in the specified directory
            if directory_path == ".":
                # Root directory - files with parent "."
                if file_dir != ".":
                    continue
            elif directory_path != file_dir:
                # Not in the requested directory
                continue
        else:
            # If we can't find original path, only include in "." (Other)
            if directory_path != ".":
                continue
        
        # Build metadata for this file
        result.append(
            {
                "filename": filename,
                "size": get_file_size(pdf_file),
                "is_old_version": is_old_version(filename),
                "last_commit_date": get_last_commit_date(original_path, repo_root),
                "github_history_url": get_github_history_url(
                    original_path, filename, github_repo
                ),
            }
        )
    
    # Sort by filename
    result.sort(key=lambda x: x["filename"])
    
    return result


def main():
    """Main function to generate the index.html file."""
    script_dir = Path(__file__).parent
    repo_root = script_dir.parent.parent
    config_file = repo_root / ".github" / "page-config.yml"
    template_dir = repo_root / ".github" / "templates"
    docs_dir = repo_root / "docs"
    output_file = docs_dir / "index.html"

    if not config_file.exists():
        print(f"Error: Configuration file not found: {config_file}")
        sys.exit(1)

    if not (template_dir / "index.html.j2").exists():
        print(f"Error: Template file not found: {template_dir / 'index.html.j2'}")
        sys.exit(1)

    if not docs_dir.exists():
        print(f"Error: Docs directory not found: {docs_dir}")
        sys.exit(1)

    # Load configuration
    with open(config_file, "r", encoding="utf-8") as f:
        config = yaml.safe_load(f)

    # Sanitize HTML in config
    if "site" in config:
        for key in ["welcome_message", "footer_text", "license_text"]:
            if key in config["site"]:
                config["site"][key] = sanitize_html(str(config["site"][key]))

    github_repo = config.get("site", {}).get("github_repo", "misho104/LecturePublic")

    # Setup Jinja2 and make list_pdf_data_in_directory available to template
    env = Environment(loader=FileSystemLoader(template_dir))
    
    def template_list_pdf_data(directory_path: str) -> list[dict]:
        return list_pdf_data_in_directory(directory_path, docs_dir, repo_root, github_repo)
    
    env.globals["list_pdf_data_in_directory"] = template_list_pdf_data
    
    template = env.get_template("index.html.j2")
    html_content = template.render(config=config)

    with open(output_file, "w", encoding="utf-8") as f:
        f.write(html_content)

    print(f"Successfully generated: {output_file}")


if __name__ == "__main__":
    main()
