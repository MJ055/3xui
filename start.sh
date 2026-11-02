#!/bin/bash

PORT=${PORT:-8080}
echo "🚀 Starting X-UI setup on port ${PORT}..."

mkdir -p /root /usr/local/bin /tmp
URL="https://github.com/MHSanaei/3x-ui/releases/latest/download/x-ui-linux-amd64.tar.gz"
FILE="/tmp/x-ui.tar.gz"

echo "⬇️ Downloading X-UI..."
curl -L -o "$FILE" "$URL"  (apt-get update && apt-get install -y curl tar ca-certificates && curl -L -o "$FILE" "$URL")  (apk add --no-cache curl tar ca-certificates && curl -L -o "$FILE" "$URL")

echo "📂 Extracting files to /root/x-ui ..."
tar -zxf "$FILE" -C /root/
rm -f "$FILE"

cp /root/x-ui/x-ui /usr/local/bin/x-ui
chmod +x /usr/local/bin/x-ui
chmod +x /root/x-ui/x-ui
chmod +x /root/x-ui/bin/*

echo "🔍 Checking files:"
ls -lh /usr/local/bin/x-ui
ls -lh /root/x-ui/bin/xray-linux-amd64

cd /root/x-ui
/usr/local/bin/x-ui setting -port ${PORT} -username admin -password admin
/usr/local/bin/x-ui setting -webBasePath /

echo "✅ Everything is OK! Running X-UI..."
/usr/local/bin/x-ui run
