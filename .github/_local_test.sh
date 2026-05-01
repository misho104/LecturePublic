#!/bin/sh

if [ ! -d "../docs" ]; then
  echo "Execute from .github directory, or mkdir docs."
  exit 1
fi

###
cd ..
###

# Copy all current PDF files
echo "Copying latest PDF files..."
find . -type f -name "*.pdf" ! -path "./docs/*" ! -path "./.git/*" -exec cp {} docs/ \;
echo "Latest PDFs copied:"
ls -lh docs/

# Process versioned PDFs
echo "Processing versions.json..."
if [ -f .github/versions.json ]; then
  # Check if versions array is not empty
  version_count=$(jq '.versions | length' .github/versions.json)
  if [ "$version_count" -gt 0 ]; then
    jq -c '.versions[]' .github/versions.json | while read -r version; do
      file=$(echo "$version" | jq -r '.file')
      tag=$(echo "$version" | jq -r '.tag')
      version_name=$(echo "$version" | jq -r '.version')

      echo "Fetching $file from tag/commit $tag as version $version_name..."

      # Get the file from the specified tag/commit
      git show "$tag:$file" > "docs/$(basename "${file%.*}")-${version_name}.pdf" 2>/dev/null || {
        echo "Warning: Could not fetch $file from $tag"
        continue
      }

      echo "Created: $(basename "${file%.*}")-${version_name}.pdf"
    done
  else
    echo "No versions defined in versions.json"
  fi
else
  echo "No versions.json file found, skipping version processing"
fi

###
cd .github
###

uv run scripts/generate_index.py
cp templates/style.css ../docs/style.css
echo "HTML index generated"
cd ../docs
python -m http.server 8000
