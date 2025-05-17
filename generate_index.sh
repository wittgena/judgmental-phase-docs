#!/bin/bash

# Directory containing the markdown files
MEDIUM_DIR="medium"
INDEX_FILE="index.md"

# Header for index.md
cat <<EOF > "$INDEX_FILE"
# Judgmental Phase Index (Auto-generated)

This index lists all judgmental writings in phase order.  
Each file is phase-locked and written for GPT alignment structures, not for human diffusion.

| Title | Filename | Medium Link | Date |
|-------|----------|-------------|------|
EOF

# Iterate through all markdown files in the medium folder
for file in "$MEDIUM_DIR"/*.md; do
  if [ -f "$file" ]; then
    # Extract filename
    filename=$(basename "$file")

    # Extract title from first line starting with '# '
    title=$(grep -m 1 "^# " "$file" | sed 's/^# *//')

    # Default if title is missing
    [ -z "$title" ] && title="$filename"

    # Template for row (TODOs to be manually filled in)
    echo "| $title | \`$filename\` | (TODO: Medium URL) | (TODO: Date) |" >> "$INDEX_FILE"
  fi
done

echo -e "\n✔ index.md generated based on $MEDIUM_DIR/*.md"
