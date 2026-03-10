#!/bin/bash

echo "--- Starting Physics Sync ---"

# 1. SAVE LOCAL WORK FIRST
git add .
git commit -m "Physics Update: $(date)" || echo "No new changes to save"

# 2. Pull changes from GitHub (in case you edited the README online)
echo "📥 Checking for web updates..."
git pull origin main --rebase

# 3. Push to the cloud
echo "🚀 Uploading to GitHub..."
git push origin main

echo "--- ✅ Sync Complete! ---"
