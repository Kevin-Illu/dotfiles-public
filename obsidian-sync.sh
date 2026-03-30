#!/bin/bash

VAULT_DIR="$HOME/workspace/notes/Enginering/"

if [ ! -d "$VAULT_DIR" ]; then
  echo "Error: El directorio $VAULT_DIR no existe."
  exit 1
fi

cd "$VAULT_DIR" || exit

echo "Bajando cambios remotos..."
if ! git pull origin main; then
  echo "Error: No se pudieron bajar los cambios. ¿Hay conflictos o falta de internet?"
  exit 1
fi

echo "Abriendo Obsidian..."
obsidian %u

echo "Subiendo cambios locales..."
git add .

# Solo hacer commit si hay cambios detectados
if ! git diff-index --quiet HEAD; then
  echo "Subiendo cambios locales..."
  git commit -m "Auto-sync $(date +'%Y-%m-%d %H:%M:%S')"
  git push origin main
else
  echo "No hay cambios locales para subir."
fi
