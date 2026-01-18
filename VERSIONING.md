# PDF Versioning Configuration

This file (`versions.json`) specifies which PDF files should have their older versions archived and made available on GitHub Pages.

## Format

```json
{
  "versions": [
    {
      "file": "path/to/file.pdf",
      "tag": "tag-name-or-commit-hash",
      "version": "v1.0"
    }
  ]
}
```

## Fields

- **file**: The path to the PDF file in the repository (e.g., `GeneralPhysics/gp1_boot1_deriv.pdf`)
- **tag**: The git tag or commit hash from which to retrieve this version
- **version**: The version identifier that will be appended to the filename. Supports various formats like `v1.0`, `v1.0.0`, `v2.1-beta`, or `v1.0.0-rc1`. The version string will create filenames like `filename-v1.0.pdf`

## Example

To archive version 1.0 of a General Physics PDF from tag `v1.0`:

```json
{
  "versions": [
    {
      "file": "GeneralPhysics/gp1_boot1_deriv.pdf",
      "tag": "v1.0",
      "version": "v1.0"
    },
    {
      "file": "GeneralPhysics/gp1_boot1_deriv.pdf",
      "tag": "v1.1",
      "version": "v1.1"
    }
  ]
}
```

This will create:
- `gp1_boot1_deriv.pdf` (latest version from main branch, marked with "Latest" badge)
- `gp1_boot1_deriv-v1.0.pdf` (from tag v1.0, marked with "Old Version" badge)
- `gp1_boot1_deriv-v1.1.pdf` (from tag v1.1, marked with "Old Version" badge)

All PDFs are organized into categories on the index page:
- **General Physics**: Files matching `gp*.pdf`
- **Policies**: Files matching policy-related keywords (grading, submission, generative, policy, guideline)
- **Other Resources**: All remaining PDF files

## Workflow

The GitHub Actions workflow automatically:

1. **Triggers** on:
   - Push to main branch
   - New releases published
   - Manual workflow dispatch

2. **Collects** all PDF files from the current repository state

3. **Processes** this `versions.json` file to fetch and rename older versions

4. **Generates** an HTML index page with all PDFs organized by category

5. **Deploys** everything to GitHub Pages in the `/docs` directory

## Notes

- The latest version (from the main branch) is always included automatically
- Tags must exist in the repository before they can be referenced
- The workflow will skip entries where the tag/commit doesn't exist and log a warning
- Versioned files are clearly marked in the HTML index with an "Old Version" badge
