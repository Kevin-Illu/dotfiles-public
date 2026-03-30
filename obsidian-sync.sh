#!/bin/bash

notify() {
  if [ "$IS_TERMUX" = false ]; then
    notify-send -i obsidian "Obsidian Sync" "$1"
  fi
}

save_changes_if_exist() {
  git add .
  if ! git diff-index --quiet HEAD; then
    echo "Subiendo cambios locales..."
    git commit -m "Auto-sync $(date +'%Y-%m-%d %H:%M:%S') desde $CURRENT_HOST"

    if git push origin main; then
      notify "Cambios guardados en la nube"
    else
      notify "Error al subir los cambios"
    fi
  else
    echo "Sin cambios locales para subir."
    notify "Todo esta al dia"
  fi
}

if [ -d /data/data/com.termux ]; then
  VAULT_DIR="$HOME/storage/shared/Documents/notes/"
  IS_TERMUX=true
  CURRENT_HOST="Pixel"
else
  VAULT_DIR="$HOME/workspace/notes/Enginering/"
  IS_TERMUX=false
  CURRENT_HOST="Arch"
fi

if [ ! -d "$VAULT_DIR" ]; then
  echo "Error: El directorio $VAULT_DIR no existe."
  exit 1
fi

cd "$VAULT_DIR" || exit


echo "Sincronizando con remoto..."

if git pull --rebase origin main; then
  notify "Notas actualizadas desde el remoto"
else
  notify "Error al descargar cambios"
  exit 1
fi

echo "Abriendo Obsidian..."
if [ "$IS_TERMUX" = true ]; then
  # Abre la app en Android (si el nombre del paquete es el estándar)
  am start --user 0 -n md.obsidian/md.obsidian.MainActivity > /dev/null 2>&1

  sleep 2 # chapuz para que se procese la apertura 
else
  obsidian %u
fi

save_changes_if_exist
