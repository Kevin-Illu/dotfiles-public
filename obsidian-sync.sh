#!/bin/bash

if [ -d /data/data/com.termux ]; then
  VAULT_DIR="$HOME/storage/shared/Documents/notes/"
  IS_TERMUX=true
else
  VAULT_DIR="$HOME/workspace/notes/Enginering/"
  IS_TERMUX=false
fi

if [ ! -d "$VAULT_DIR" ]; then
  echo "Error: El directorio $VAULT_DIR no existe."
  exit 1
fi

cd "$VAULT_DIR" || exit

echo "Sincronizando con remoto..."
git pull --rebase origin main || { echo "Error en el pull. Revisa conflictos."; exit 1; }

echo "Abriendo Obsidian..."
if [ "$IS_TERMUX" = true ]; then
  # Abre la app en Android (si el nombre del paquete es el estándar)
  am start --user 0 -n md.obsidian/md.obsidian.MainActivity > /dev/null 2>&1
else
  obsidian %u
fi

git add .
if ! git diff-index --quiet HEAD; then
  echo "Subiendo cambios locales..."
  git commit -m "Auto-sync $(date +'%Y-%m-%d %H:%M:%S') desde $(hostname)"
  git push origin main
else
  echo "Sin cambios locales para subir."
fi
