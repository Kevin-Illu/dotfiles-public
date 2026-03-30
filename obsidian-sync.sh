#!/bin/bash

VAULT_DIR="$HOME/workspace/notes/Enginering/"

cd "$VAULT_DIR" || exit

echo "Bajando cambios remotos..."
git pull origin main

obsidian %u

echo "Subiendo cambios locales..."
git add .
git commit -m "Auto-sync $(date +'%Y-%m-%d %H:%M:%S')"
git push origin main
