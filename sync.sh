#!/bin/bash

echo "--- Starting Physics Sync ---"

# 1. Pull changes from GitHub (in case you edited the README online)
echo "📥 Checking for web updates..."
git pull origin main

# 2. Stage all new files and movements
echo "📂 Indexing new notes and code..."
git add .

# 3. Commit with a timestamp
echo "✍️ Signing off on changes..."
git commit -m "Physics Update: $(date +'%Y-%m-%d %H:%M')"

# 4. Push to the cloud
echo "🚀 Uploading to GitHub..."
git push origin main

echo "--- ✅ Sync Complete! ---"
