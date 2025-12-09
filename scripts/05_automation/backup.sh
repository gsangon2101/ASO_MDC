#!/bin/bash

# Directorio temporal local
TMP_DIR="/tmp/backup"

# Datos del backup
HOSTNAME_LOCAL="$(hostname)"
FECHA="$(date +%Y%m%d%H%M)"
BACKUP_NAME="backup_${HOSTNAME_LOCAL}_${FECHA}.tar"

# Destino remoto (ajusta estos datos)
REMOTE_USER="asir"
REMOTE_HOST="guillermo.asir"
REMOTE_DIR="/backups/${REMOTE_USER}"

# 1) Comprobar que hay al menos una ruta como parámetro
if [ "$#" -lt 1 ]; then
    echo "Uso: $0 ruta1 [ruta2 ...]"
    exit 1
fi

# 2) Crear directorio temporal limpio
rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR" || exit 1

# 3) Comprimir cada ruta en un .zst dentro de $TMP_DIR
for RUTA in "$@"; do
    if [ ! -e "$RUTA" ]; then
        echo "ERROR: La ruta '$RUTA' no existe"
        exit 1
    fi

    NOMBRE=$(basename "$RUTA")
    DESTINO_ZST="${TMP_DIR}/${NOMBRE}.zst"

    zstd -q -r -o "$DESTINO_ZST" "$RUTA"
    if [ $? -ne 0 ]; then
        echo "ERROR al comprimir '$RUTA'"
        exit 1
    fi
done

# 4) Crear el tar sin compresión con todos los .zst
cd "$TMP_DIR" || exit 1
tar -cf "$BACKUP_NAME" *.zst || exit 1

# 5) Subir el tar a la máquina remota
ssh "${REMOTE_USER}@${REMOTE_HOST}" "mkdir -p '${REMOTE_DIR}'"
scp "$BACKUP_NAME" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/" || exit 1

# 6) Rotar backups en la máquina remota (mantener solo los 10 más recientes)
ssh "${REMOTE_USER}@${REMOTE_HOST}" "
  cd '${REMOTE_DIR}' || exit 1
  ls -1t backup_${HOSTNAME_LOCAL}_*.tar 2>/dev/null | tail -n +11 | xargs -r rm --
"
# 7) Limpiar directorio temporal local
cd /
rm -rf "$TMP_DIR"

exit 0
