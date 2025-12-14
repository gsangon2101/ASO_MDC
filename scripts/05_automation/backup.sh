#!/bin/bash
TMP_DIR="/tmp/backup"

HOSTNAME_LOCAL="$(hostname)"
FECHA="$(date +%Y%m%d%H%M)"
BACKUP_NAME="backup_${HOSTNAME_LOCAL}_${FECHA}.tar"
BACKUP_ZST="${BACKUP_NAME}.zst"

REMOTE_USER="user"
REMOTE_HOST="192.168.1.140"
REMOTE_DIR="/home/user/backups"   # o la ruta absoluta que quieras

if [ "$#" -lt 1 ]; then
    echo "Uso: $0 ruta1 [ruta2 ...]"
    exit 1
fi

rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR" || exit 1

# 1) Crear un tar con TODAS las rutas
tar -cf "${TMP_DIR}/${BACKUP_NAME}" "$@" || {
    echo "ERROR al crear tar"
    exit 1
}

# 2) Comprimir ese tar con zstd
zstd -q "${TMP_DIR}/${BACKUP_NAME}" -o "${TMP_DIR}/${BACKUP_ZST}" || {
    echo "ERROR al comprimir backup"
    exit 1
}

echo "Contenido de $TMP_DIR:"
ls -lh "$TMP_DIR"

cd "$TMP_DIR" || exit 1

# 3) Subir el backup .tar.zst a la máquina remota
ssh "${REMOTE_USER}@${REMOTE_HOST}" "mkdir -p '${REMOTE_DIR}'"
scp "$BACKUP_ZST" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/" || exit 1

# 4) Rotar (mantener solo los 10 más recientes)
ssh "${REMOTE_USER}@${REMOTE_HOST}" "
  cd '${REMOTE_DIR}' || exit 1
  ls -1t backup_${HOSTNAME_LOCAL}_*.tar.zst 2>/dev/null | tail -n +11 | xargs -r rm --
"

cd /
rm -rf "$TMP_DIR"
exit 0
