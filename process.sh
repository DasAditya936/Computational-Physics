#!/bin/bash

# --- Intermediate Processing Stage ---
echo "🧪 Running Pre-processor..."

# Loop through your HTML notes
# This targets the specific constant structure: Topics/[Module]/notes/*.html
find Topics -name "*.html" -type f | while read -r file; do
    echo "Processing: $file"
    
    # 1. Trim Math (via markdown folder tool)
    # 2. Relativize Paths (via root tool)
    # 3. Save to a temporary file, then overwrite original
    perl ./markdown/matTrim.pl "$file" | perl ./rel.pl > "$file.tmp" && mv "$file.tmp" "$file"
done

echo "✨ Pre-processing complete. Local files are now Web-Ready."
