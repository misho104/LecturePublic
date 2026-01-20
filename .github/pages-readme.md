# GitHub Pages for Lecture Materials

This directory contains the configuration and templates for generating the GitHub Pages index that displays PDF lecture materials.

## Overview

The GitHub Pages for this repository provides an organized, easy-to-navigate archive of all PDF lecture materials. The page is automatically generated and deployed whenever changes are pushed to the main branch.

## File Structure

- **`page-config.yml`** - Configuration file for site metadata and display options
- **`templates/index.html.j2`** - Jinja2 template for the HTML page structure
- **`templates/style.css`** - CSS stylesheet for the page appearance
- **`scripts/generate_index.py`** - Python script that generates the HTML from the template
- **`versions.json`** - Configuration for archived PDF versions (see VERSIONING.md)
- **`VERSIONING.md`** - Documentation for the PDF versioning system

## How It Works

1. **GitHub Actions Workflow** (`.github/workflows/deploy-pages.yml`):
   - Triggers on push to main branch, new releases, or manual dispatch
   - Copies all PDF files to the `docs/` directory
   - Processes versioned PDFs from `.github/versions.json`
   - Installs Python dependencies (PyYAML, Jinja2)
   - Runs the generator script to create the HTML index
   - Deploys the `docs/` directory to GitHub Pages

2. **Generator Script** (`.github/scripts/generate_index.py`):
   - Reads configuration from `page-config.yml`
   - Uses the Jinja2 template to generate HTML
   - For each category in the template, calls `list_pdf_data_in_directory()` to get PDF metadata
   - Generates file information including size, last commit date, and version badges
   - Writes the rendered HTML to `docs/index.html`

3. **Template Rendering**:
   - The Jinja2 template defines the page structure and categories
   - Currently includes two fixed categories:
     - **Boot Camp**: PDFs from the `GeneralPhysics` directory
     - **Policies**: PDFs from the `Policies` directory
   - Each PDF is displayed with metadata (update date, version badge, history link)

## Quick Start: Customizing Your Page

### 1. Toggle Display Options

Edit the `display` section in `.github/page-config.yml`:

```yaml
display:
  show_file_sizes: true       # Show/hide file sizes
  show_version_badges: true   # Show/hide version badges
  version_badge_text: "Latest"
  old_version_badge_text: "Old Version"
```

### 2. Customize Colors

Edit CSS variables in `.github/templates/style.css`:

```css
:root {
    --primary-color: #0366d6;
    --background-color: #f5f5f5;
    --card-background: white;
    --font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto;
}
```

### 3. Add or Modify Categories

To add a new category or change existing ones, edit `.github/templates/index.html.j2`:

```html
<h2>My New Category</h2>
<p class="category-description">Description of this category</p>
<ul class="pdf-list">
    {% for file in list_pdf_data_in_directory("DirectoryName") %}{{ pdf_item(file) }}{% endfor %}
</ul>
```

Replace `"DirectoryName"` with the path to your directory containing PDFs (e.g., `"GeneralPhysics"`, `"Policies"`).

## Testing Locally

To test your changes before pushing:

```bash
# Install dependencies (requires Python 3.11+)
pip install pyyaml jinja2

# Create docs directory and copy PDFs
mkdir -p docs
find . -type f -name "*.pdf" ! -path "./docs/*" ! -path "./.git/*" -exec cp {} docs/ \;

# Generate the index
python .github/scripts/generate_index.py

# Copy the stylesheet
cp .github/templates/style.css docs/style.css

# Open the generated file
open docs/index.html  # macOS
xdg-open docs/index.html  # Linux
```

## Configuration Reference

### page-config.yml

```yaml
# Display options
display:
  show_file_sizes: boolean       # Show file sizes next to PDFs
  show_version_badges: boolean   # Show "Latest" or "Old Version" badges
  version_badge_text: string     # Text for latest version badge
  old_version_badge_text: string # Text for old version badge
  sort_by: string                # Currently only "name" is supported
```

## Adding Old Versions

To archive older versions of PDFs, edit `.github/versions.json`. See `VERSIONING.md` for detailed instructions.

## Troubleshooting

**Q: My changes aren't showing up on the live site**
- Commit and push your changes to the main branch
- Check the Actions tab in GitHub for workflow run status
- Wait a few minutes for GitHub Pages to update after deployment completes

**Q: The page looks broken**
- Check your YAML syntax in `page-config.yml` using a YAML validator
- Test locally first using the commands above
- Check the workflow logs in GitHub Actions for error messages

**Q: A PDF isn't appearing on the page**
- Ensure the PDF is in the repository (not in `.git` or `docs` directories)
- Check that the directory path in the template matches your file location
- Verify the workflow successfully copied the file (check Actions logs)

**Q: I want to completely redesign the page**
- Edit `.github/templates/index.html.j2` for structure and content
- Edit `.github/templates/style.css` for styling
- The template has access to `config` (from page-config.yml) and can call `list_pdf_data_in_directory(dir_path)` to get PDF metadata

## Advanced Customization

### Available Template Variables

In `index.html.j2`, you have access to:

- `config` - All settings from `page-config.yml`
- `list_pdf_data_in_directory(path)` - Function that returns list of PDF metadata

### PDF Metadata Structure

Each item returned by `list_pdf_data_in_directory()` contains:

```python
{
    "filename": str,              # PDF filename
    "size": str,                  # Human-readable file size (e.g., "2.3MB")
    "is_old_version": bool,       # True if filename contains -v followed by digit
    "last_commit_date": str,      # Last commit date (YYYY-MM-DD) or empty string
    "github_history_url": str     # URL to view commit history for this file
}
```

### Jinja2 Template Examples

**Display PDFs in a custom format:**

```html
{% for file in list_pdf_data_in_directory("MyDirectory") %}
    <div>
        <a href="{{ file.filename }}">{{ file.filename }}</a>
        ({{ file.size }}, updated {{ file.last_commit_date }})
    </div>
{% endfor %}
```

**Conditionally show content:**

```html
{% if config.display.show_file_sizes %}
    <span>{{ file.size }}</span>
{% endif %}
```

## Examples

### Example 1: Hide version badges

Edit `.github/page-config.yml`:

```yaml
display:
  show_version_badges: false
```

### Example 2: Change site title

Edit `.github/page-config.yml`:

```yaml
site:
  title: "Physics Lecture Archive"
  description: "Complete archive of physics lecture materials"
```

### Example 3: Add a new category for homework

Edit `.github/templates/index.html.j2`, adding before the footer:

```html
<h2>Homework Assignments</h2>
<p class="category-description">Problem sets and assignments</p>
<ul class="pdf-list">
    {% for file in list_pdf_data_in_directory("Homework") %}{{ pdf_item(file) }}{% endfor %}
</ul>
```

Then create a `Homework` directory in your repository and add PDF files to it.

## Requirements

- Python 3.11 or later (for the `list[dict]` type hint syntax)
- PyYAML and Jinja2 libraries

## Security Notes

The `generate_index.py` script includes security measures:
- Path validation to prevent directory traversal attacks
- Subprocess timeout to prevent infinite execution
- Safe YAML loading with `yaml.safe_load()`
- Path resolution validation to ensure files are within the repository

These protections ensure the build process is secure even if malicious input is provided.
