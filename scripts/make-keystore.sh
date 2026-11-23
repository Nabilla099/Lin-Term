#!/usr/bin/env bash
# Membuat keystore untuk menandatangani Lin Term (sekali saja).
# Butuh: keytool (JDK) dan openssl.  Jalankan: bash scripts/make-keystore.sh
set -euo pipefail
command -v keytool >/dev/null || { echo "keytool tidak ada. Pasang JDK 17 dulu."; exit 1; }
command -v openssl >/dev/null || { echo "openssl tidak ada."; exit 1; }
[ ! -e lin.jks ] || { echo "lin.jks sudah ada, tidak ditimpa."; exit 1; }

PASS="$(openssl rand -base64 24 | tr -dc 'A-Za-z0-9' | head -c 24)"
ALIAS="lin"

keytool -genkeypair -storetype PKCS12 -keystore lin.jks -alias "$ALIAS" \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -storepass "$PASS" -keypass "$PASS" \
  -dname "CN=Lin Term, O=Lin, C=ID"

base64 < lin.jks | tr -d '\n' > lin.jks.base64.txt

cat <<MSG

Keystore dibuat: lin.jks
Isi 4 GitHub Secrets berikut (Settings > Secrets and variables > Actions):

  KEYSTORE_BASE64   = isi file lin.jks.base64.txt
  KEYSTORE_PASSWORD = $PASS
  KEY_ALIAS         = $ALIAS
  KEY_PASSWORD      = $PASS

PENTING: simpan lin.jks dan password di tempat aman (cadangkan di luar GitHub).
Jangan di-commit. Jika hilang, pengguna tidak bisa memperbarui aplikasi.
MSG
