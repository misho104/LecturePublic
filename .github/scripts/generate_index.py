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

import yaml
from jinja2 import Environment, FileSystemLoader

REPO_URL = "https://github.com/misho104/LecturePublic"
REPO_ROOT = Path(__file__).parent.parent.parent
DOCS_DIR = REPO_ROOT / "docs"


def get_file_size(filepath: Path) -> str:
    """Get human-readable file size."""
    size_bytes = filepath.stat().st_size
    for unit in ["B", "KB", "MB"]:
        if size_bytes < 1024:
            return f"{size_bytes}{unit}"
        size_bytes //= 1024
    return f"{size_bytes}GB"


def is_old_version(filename: str) -> bool:
    """Check if filename represents an old version (contains -v followed by digits)."""
    return bool(re.search(r"-v\d", filename))


def get_last_commit_date(path: Path) -> str:
    """
    Get the last commit date for a file using git log.
    Returns formatted date string or None if unavailable.
    """
    # Validate path to prevent command injection and path traversal
    try:
        # Ensure the resolved path is within the repository (Python 3.9+)
        resolved_path = path.resolve()
        resolved_path.relative_to(REPO_ROOT.resolve())
    except (ValueError, OSError) as e:
        print(f"Warning: Path outside repository or invalid: {path} ({e})")
        return ""

    try:
        # Use git log to get the last commit date for this file
        result = subprocess.run(
            ["git", "log", "-1", "--format=%ci", "--", str(path)],
            cwd=REPO_ROOT,
            capture_output=True,
            text=True,
            timeout=5,
        )
        if result.returncode == 0 and result.stdout.strip():
            # Parse the date and format it (get just the date part: YYYY-MM-DD)
            date_str = result.stdout.strip().split()[0]
            return date_str
        return ""
    except Exception as e:
        print(f"Warning: Could not get commit date for {path}: {e}")
        return ""


def list_pdf_data_in_directory(dir: str) -> list[dict]:
    """
    List PDF files in a specific directory with their metadata.
    Files that are not published in docs_dir are excluded.

    Args:
        dir: Directory path

    Returns:
        List of dictionaries containing file metadata for PDFs in the directory.
    """
    result = []
    for pdf_file in (REPO_ROOT / dir).glob("*.pdf"):
        filename = pdf_file.name
        if not (DOCS_DIR / filename).exists():
            continue
        result.append(
            {
                "filename": filename,
                "size": get_file_size(pdf_file),
                "is_old_version": is_old_version(filename),
                "last_commit_date": get_last_commit_date(pdf_file),
                "github_history_url": f"{REPO_URL}/commits/main/{dir}/{filename}",
            }
        )

    result.sort(key=lambda x: str(x["filename"]))
    return result


def main():
    """Main function to generate the index.html file."""
    config_file = REPO_ROOT / ".github" / "page-config.yml"
    template_dir = REPO_ROOT / ".github" / "templates"
    output_file = DOCS_DIR / "index.html"

    if not config_file.exists():
        print(f"Error: Configuration file not found: {config_file}")
        sys.exit(1)
    if not (template_dir / "index.html.j2").exists():
        print(f"Error: Template file not found: {template_dir / 'index.html.j2'}")
        sys.exit(1)
    if not DOCS_DIR.exists():
        print(f"Error: Docs directory not found: {DOCS_DIR}")
        sys.exit(1)

    with open(config_file, "r", encoding="utf-8") as f:
        config = yaml.safe_load(f)

    env = Environment(loader=FileSystemLoader(template_dir))

    # template function.
    env.globals["list_pdf_data_in_directory"] = list_pdf_data_in_directory

    template = env.get_template("index.html.j2")
    html_content = template.render(config=config)

    with open(output_file, "w", encoding="utf-8") as f:
        f.write(html_content)

    print(f"Successfully generated: {output_file}")


if __name__ == "__main__":
    main()
