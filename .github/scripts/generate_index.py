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

REPO_URL = "https://github.com/misho104/LecturePublic/"


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


def get_last_commit_date(original_path: Path, repo_root: Path) -> str:
    """
    Get the last commit date for a file using git log.
    Returns formatted date string or None if unavailable.
    """
    # Validate path to prevent command injection and path traversal
    try:
        resolved_path = original_path.resolve()
        resolved_repo_root = repo_root.resolve()
        # Ensure the resolved path is within the repository (Python 3.9+)
        resolved_path.relative_to(resolved_repo_root)
    except (ValueError, OSError) as e:
        print(f"Warning: Path outside repository or invalid: {original_path} ({e})")
        return ""

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
        return ""
    except Exception as e:
        print(f"Warning: Could not get commit date for {path_str}: {e}")
        return ""


def get_github_history_url(original_path: Path) -> str:
    """Build GitHub history URL for a file."""
    return ""


def list_pdf_data_in_directory(dir: str, repo_root: Path) -> list[dict]:
    """
    List PDF files in a specific directory with their metadata.

    Args:
        dir: Directory path (e.g.,"GeneralPhysics")
        repo_root: Path to repository root

    Returns:
        List of dictionaries containing file metadata for PDFs in the directory
    """
    result = []
    for pdf_file in (repo_root / dir).glob("*.pdf"):
        filename = pdf_file.name
        result.append(
            {
                "filename": filename,
                "size": get_file_size(pdf_file),
                "is_old_version": is_old_version(filename),
                "last_commit_date": get_last_commit_date(pdf_file, repo_root),
                "github_history_url": f"{REPO_URL}/commits/main/{dir}/{filename}",
            }
        )

    # Sort by filename
    result.sort(key=lambda x: str(x["filename"]))

    return result


def main():
    """Main function to generate the index.html file."""
    repo_root = Path(__file__).parent.parent.parent
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

    with open(config_file, "r", encoding="utf-8") as f:
        config = yaml.safe_load(f)

    env = Environment(loader=FileSystemLoader(template_dir))

    # template function.
    def template_list_pdf_data(directory_path: str) -> list[dict]:
        """List PDFs in a given directory.

        Files that are not published in docs_dir is excluded."""
        for file in list_pdf_data_in_directory(directory_path, repo_root):
            print(f"::: {file['filename']} {directory_path}")
            print(f"    {docs_dir / file['filename']}")
            print(f"    {(docs_dir / file['filename']).exists()}")
            print(f"{file}")
        return [
            file
            for file in list_pdf_data_in_directory(directory_path, repo_root)
            if (docs_dir / file["filename"]).exists()
        ]

    env.globals["list_pdf_data_in_directory"] = template_list_pdf_data

    template = env.get_template("index.html.j2")
    html_content = template.render(config=config)

    with open(output_file, "w", encoding="utf-8") as f:
        f.write(html_content)

    print(f"Successfully generated: {output_file}")


if __name__ == "__main__":
    main()
