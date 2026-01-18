#!/usr/bin/env python3
"""
Generate HTML index page for GitHub Pages using Jinja2 templates.

This script reads PDF files from the docs directory, categorizes them based on
the configuration in page-config.yml, and generates an index.html file using
the Jinja2 template.
"""

import os
import re
import sys
import subprocess
from pathlib import Path
from typing import List, Dict, Any, Optional

try:
    import yaml
    from jinja2 import Environment, FileSystemLoader
except ImportError:
    print("Error: Required packages not installed.")
    print("Install with: pip install pyyaml jinja2")
    sys.exit(1)


def validate_css_value(value: str, allowed_chars: str = r'a-zA-Z0-9#\-,\.\s\'') -> str:
    """
    Validate CSS values to prevent CSS injection.
    Only allows alphanumeric characters and basic CSS syntax.
    Does not allow parentheses, colons, or other potentially dangerous characters.
    """
    if not value:
        return value
    
    # Remove any characters that aren't in the allowed set
    pattern = f'[^{allowed_chars}]'
    sanitized = re.sub(pattern, '', value)
    
    # Truncate to reasonable length
    return sanitized[:200]


def sanitize_html(html: str) -> str:
    """
    Sanitize HTML to allow only safe tags and attributes.
    Currently only allows <a> tags with href attributes.
    """
    if not html:
        return html
    
    # Very simple sanitization: only allow <a href="..."> tags
    # Remove all tags except <a>
    result = re.sub(r'<(?!/?a[\s>])[^>]*>', '', html)
    
    # Ensure href attributes only contain safe URLs (http/https)
    result = re.sub(r'href=["\'](?!https?://)[^"\']*["\']', 'href="#"', result)
    
    return result


def get_file_size(filepath: Path) -> str:
    """Get human-readable file size."""
    size_bytes = filepath.stat().st_size
    for unit in ['B', 'KB', 'MB', 'GB']:
        if size_bytes < 1024.0:
            return f"{size_bytes:.1f}{unit}"
        size_bytes /= 1024.0
    return f"{size_bytes:.1f}TB"


def is_old_version(filename: str) -> bool:
    """Check if filename represents an old version (contains -v followed by digits)."""
    return bool(re.search(r'-v\d', filename))


def get_last_commit_date(filename: str, repo_root: Path) -> Optional[str]:
    """
    Get the last commit date for a file using git log.
    Searches for the original file location in the repository.
    Returns formatted date string or None if unavailable.
    """
    try:
        # Try to find the original file in the repository (outside docs directory)
        original_path = None
        
        for pdf_path in repo_root.glob(f'**/{filename}'):
            # Skip files in docs or .git directories
            try:
                relative = pdf_path.relative_to(repo_root)
                if not str(relative).startswith('docs/') and not str(relative).startswith('.git/'):
                    original_path = relative
                    break
            except ValueError:
                continue
        
        if not original_path:
            return None
        
        # Use git log to get the last commit date for this file
        result = subprocess.run(
            ['git', 'log', '-1', '--format=%ci', '--', str(original_path)],
            cwd=repo_root,
            capture_output=True,
            text=True,
            timeout=5
        )
        
        if result.returncode == 0 and result.stdout.strip():
            # Parse the date and format it
            date_str = result.stdout.strip().split()[0]  # Get just the date part (YYYY-MM-DD)
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
    # Try to find the original file in the repository (outside docs directory)
    original_path = None
    
    try:
        # Search for the file in the repository
        for pdf_path in repo_root.glob(f'**/{filename}'):
            # Skip files in docs or .git directories
            try:
                relative = pdf_path.relative_to(repo_root)
                if not str(relative).startswith('docs/') and not str(relative).startswith('.git/'):
                    original_path = relative
                    break
            except ValueError:
                continue
    except Exception as e:
        print(f"Warning: Could not search for original location of {filename}: {e}")
    
    # If we found the original path, use it; otherwise just use the filename
    file_path = str(original_path) if original_path else filename
    
    return f"https://github.com/{github_repo}/commits/main/{file_path}"


def main():
    """Main function to generate the index.html file."""
    # Determine paths
    script_dir = Path(__file__).parent
    repo_root = script_dir.parent.parent  # Assuming script is in .github/scripts/
    config_file = repo_root / '.github' / 'page-config.yml'
    template_dir = repo_root / '.github' / 'templates'
    template_file = 'index.html.j2'
    docs_dir = repo_root / 'docs'
    output_file = docs_dir / 'index.html'
    
    # Check if config file exists
    if not config_file.exists():
        print(f"Error: Configuration file not found: {config_file}")
        sys.exit(1)
    
    # Check if template exists
    if not (template_dir / template_file).exists():
        print(f"Error: Template file not found: {template_dir / template_file}")
        sys.exit(1)
    
    # Load configuration
    with open(config_file, 'r', encoding='utf-8') as f:
        config = yaml.safe_load(f)
    
    # Sanitize CSS values if style section exists
    if 'style' in config:
        for key in ['primary_color', 'background_color', 'card_background', 'font_family']:
            if key in config['style']:
                config['style'][key] = validate_css_value(str(config['style'][key]))
    
    # Sanitize HTML in site section
    if 'site' in config:
        for key in ['welcome_message', 'footer_text', 'license_text']:
            if key in config['site']:
                config['site'][key] = sanitize_html(str(config['site'][key]))
    
    # Get all PDF files from docs directory
    if not docs_dir.exists():
        print(f"Error: Docs directory not found: {docs_dir}")
        sys.exit(1)
    
    pdf_files = list(docs_dir.glob('*.pdf'))
    
    if not pdf_files:
        print("Warning: No PDF files found in docs directory")
    
    print(f"Found {len(pdf_files)} PDF files")
    
    # Get GitHub repository information
    github_repo = config.get('site', {}).get('github_repo', 'misho104/LecturePublic')
    
    # Build file list with metadata
    all_files = []
    for pdf_file in pdf_files:
        filename = pdf_file.name
        all_files.append({
            'filename': filename,
            'size': get_file_size(pdf_file),
            'is_old_version': is_old_version(filename),
            'last_commit_date': get_last_commit_date(filename, repo_root),
            'github_history_url': get_github_history_url(filename, github_repo, repo_root)
        })
    
    # Sort files by name
    all_files.sort(key=lambda x: x['filename'])
    
    print(f"Processed {len(all_files)} PDF files")
    
    # Setup Jinja2 environment
    env = Environment(loader=FileSystemLoader(template_dir))
    template = env.get_template(template_file)
    
    # Render template
    html_content = template.render(config=config, all_files=all_files)
    
    # Write output
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(html_content)
    
    print(f"Successfully generated: {output_file}")


if __name__ == '__main__':
    main()
