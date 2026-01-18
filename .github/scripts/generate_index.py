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
from pathlib import Path
from typing import List, Dict, Any

try:
    import yaml
    from jinja2 import Environment, FileSystemLoader
except ImportError:
    print("Error: Required packages not installed.")
    print("Install with: pip install pyyaml jinja2")
    sys.exit(1)


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


def categorize_files(pdf_files: List[Path], categories_config: List[Dict]) -> List[Dict[str, Any]]:
    """
    Categorize PDF files based on configuration patterns.
    
    Returns a list of categories with their matched files.
    Files are matched to the first category whose pattern matches.
    """
    categories = []
    matched_files = set()
    
    for cat_config in categories_config:
        category = {
            'name': cat_config['name'],
            'icon': cat_config.get('icon', ''),
            'description': cat_config.get('description', ''),
            'files': []
        }
        
        patterns = cat_config.get('patterns', [])
        
        for pdf_file in pdf_files:
            if pdf_file in matched_files:
                continue
                
            filename = pdf_file.name
            
            # Check if filename matches any pattern in this category
            for pattern in patterns:
                if re.match(pattern, filename):
                    category['files'].append({
                        'filename': filename,
                        'size': get_file_size(pdf_file),
                        'is_old_version': is_old_version(filename)
                    })
                    matched_files.add(pdf_file)
                    break
        
        # Sort files by name
        category['files'].sort(key=lambda x: x['filename'])
        categories.append(category)
    
    return categories


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
    with open(config_file, 'r') as f:
        config = yaml.safe_load(f)
    
    # Get all PDF files from docs directory
    if not docs_dir.exists():
        print(f"Error: Docs directory not found: {docs_dir}")
        sys.exit(1)
    
    pdf_files = list(docs_dir.glob('*.pdf'))
    
    if not pdf_files:
        print("Warning: No PDF files found in docs directory")
    
    print(f"Found {len(pdf_files)} PDF files")
    
    # Categorize files
    categories = categorize_files(pdf_files, config.get('categories', []))
    
    # Print summary
    for category in categories:
        print(f"Category '{category['name']}': {len(category['files'])} files")
    
    # Setup Jinja2 environment
    env = Environment(loader=FileSystemLoader(template_dir))
    template = env.get_template(template_file)
    
    # Render template
    html_content = template.render(config=config, categories=categories)
    
    # Write output
    with open(output_file, 'w') as f:
        f.write(html_content)
    
    print(f"Successfully generated: {output_file}")


if __name__ == '__main__':
    main()
