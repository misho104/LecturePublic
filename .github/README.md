# GitHub Pages Template System

This directory contains the template engine setup for generating the GitHub Pages index.

## Overview

The GitHub Pages for this repository now uses a template-based system (Jinja2 with Python) instead of hardcoded shell scripts. This makes it much easier to customize the appearance, organization, and content of the PDF archive page.

## Files

- **`page-config.yml`** - Main configuration file for customizing the page
- **`templates/index.html.j2`** - Jinja2 template for the HTML page
- **`scripts/generate_index.py`** - Python script that generates the HTML from the template

## Quick Start: Customizing Your Page

### 1. Change Site Title and Messages

Edit `.github/page-config.yml`:

```yaml
site:
  title: "My Custom Title"
  welcome_message: "Your custom welcome message here"
```

### 2. Add or Modify Categories

Edit the `categories` section in `.github/page-config.yml`:

```yaml
categories:
  - name: "My New Category"
    icon: "🎓"
    patterns:
      - "^custom.*\\.pdf$"  # Matches files starting with "custom"
    description: "Description of this category"
```

**Pattern Notes:**
- Patterns are Python regular expressions
- Use `^` for start of filename, `$` for end
- Use `.*` to match any characters
- Example patterns:
  - `"^gp.*\\.pdf$"` - Matches gp*.pdf files
  - `".*test.*\\.pdf$"` - Matches any PDF with "test" in the name
  - `".*\\.pdf$"` - Matches all PDF files (catch-all)

### 3. Customize Colors and Fonts

Uncomment and edit the `style` section in `.github/page-config.yml`:

```yaml
style:
  primary_color: "#0366d6"
  background_color: "#f5f5f5"
  card_background: "white"
  font_family: "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto"
```

### 4. Toggle Features

Edit the `display` section in `.github/page-config.yml`:

```yaml
display:
  show_file_sizes: true      # Show/hide file sizes
  show_version_badges: true  # Show/hide version badges
  version_badge_text: "Latest"
  old_version_badge_text: "Old Version"
```

## Advanced Customization

### Editing the HTML Template

For deeper customization, edit `.github/templates/index.html.j2`. This is a Jinja2 template with full access to:

- `config` - All settings from page-config.yml
- `categories` - List of categories with their files

Example Jinja2 syntax:
```html
{% for category in categories %}
  <h2>{{ category.name }}</h2>
  {% for file in category.files %}
    <a href="{{ file.filename }}">{{ file.filename }}</a>
  {% endfor %}
{% endfor %}
```

### Modifying the Generator Script

The Python script at `.github/scripts/generate_index.py` handles:
- Reading PDF files
- Categorizing them based on patterns
- Rendering the template

You can modify this script to add custom logic, filtering, or sorting.

## Testing Locally

To test your changes before pushing:

```bash
# Install dependencies
pip install pyyaml jinja2

# Copy PDFs to docs directory (simulating the workflow)
mkdir -p docs
find . -type f -name "*.pdf" ! -path "./docs/*" -exec cp {} docs/ \;

# Generate the index
python .github/scripts/generate_index.py

# Open the generated file
open docs/index.html  # macOS
xdg-open docs/index.html  # Linux
```

## How It Works

1. **GitHub Actions Workflow** (`.github/workflows/deploy-pages.yml`):
   - Copies all PDFs to `docs/` directory
   - Processes versioned PDFs from `versions.json`
   - Installs Python dependencies (PyYAML, Jinja2)
   - Runs the generator script
   - Deploys to GitHub Pages

2. **Generator Script**:
   - Reads configuration from `page-config.yml`
   - Scans PDF files in `docs/` directory
   - Categorizes files using regex patterns
   - Loads the Jinja2 template
   - Renders HTML with categorized files
   - Writes `docs/index.html`

3. **Template Rendering**:
   - Jinja2 processes the template with config and file data
   - CSS variables allow easy color customization
   - Categories are rendered in order
   - Files within categories are sorted alphabetically

## Configuration Reference

### Site Section
```yaml
site:
  title: string              # Page title
  welcome_message: string    # Welcome text below title
  footer_text: string        # Footer message
  license_text: string       # License info (can include HTML)
```

### Categories Section
```yaml
categories:
  - name: string            # Category display name
    icon: string            # Optional emoji or icon
    patterns:               # List of regex patterns
      - string
    description: string     # Optional description
```

### Display Section
```yaml
display:
  show_file_sizes: boolean       # Show file sizes
  show_version_badges: boolean   # Show version badges
  version_badge_text: string     # Text for latest version badge
  old_version_badge_text: string # Text for old version badge
  sort_by: string                # Sorting method (currently only 'name')
```

### Style Section (Optional)
```yaml
style:
  primary_color: string      # Hex color for links and accents
  background_color: string   # Page background color
  card_background: string    # Card/item background color
  font_family: string        # CSS font-family value
```

## Troubleshooting

**Q: My changes aren't showing up on the live site**
- Make sure you committed and pushed your changes
- Check the Actions tab for workflow run status
- Wait a few minutes for GitHub Pages to update

**Q: The page looks broken**
- Check your YAML syntax in `page-config.yml`
- Test locally first using the commands above
- Check the workflow logs in GitHub Actions

**Q: Files aren't being categorized correctly**
- Review your regex patterns in the categories section
- Remember: files match the first pattern that succeeds
- Test your regex at [regex101.com](https://regex101.com) (use Python flavor)

**Q: I want to add custom HTML/CSS**
- Edit `.github/templates/index.html.j2` directly
- CSS can be added in the `<style>` section
- Jinja2 template syntax: `{{ variable }}` and `{% for/if %}`

## Examples

### Example 1: Add a new category for lecture notes

```yaml
categories:
  - name: "Lecture Notes"
    icon: "📝"
    patterns:
      - "^lecture.*\\.pdf$"
      - "^notes.*\\.pdf$"
    description: "Class lecture notes and handouts"
```

### Example 2: Change theme to dark mode

```yaml
style:
  primary_color: "#58a6ff"
  background_color: "#0d1117"
  card_background: "#161b22"
```

Then update the template's color variables for text to be light colored.

### Example 3: Hide version badges

```yaml
display:
  show_version_badges: false
```
