#!/bin/bash

echo "🚀 Starting X-UI setup on port ${PORT}..."

mkdir -p /root
mkdir -p /usr/local/bin
mkdir -p /tmp

echo "🔧 Installing curl and tar..."
apt-get update -y
apt-get install -y curl tar ca-certificates tzdata
apk add --no-cache curl tar ca-certificates tzdata

echo "⬇️ Downloading X-UI..."
curl -L -o /tmp/x-ui.tar.gz https://github.com/MHSanaei/3x-ui/releases/latest/download/x-ui-linux-amd64.tar.gz

echo "📂 Extracting files to /root/x-ui ..."
tar -zxf /tmp/x-ui.tar.gz -C /root/
rm -f /tmp/x-ui.tar.gz

cp /root/x-ui/x-ui /usr/local/bin/x-ui
chmod 755 /usr/local/bin/x-ui
chmod 755 /root/x-ui/x-ui
chmod 755 /root/x-ui/bin/xray-linux-amd64

echo "🔍 Checking files:"
ls -lh /usr/local/bin/x-ui
ls -lh /root/x-ui/bin/xray-linux-amd64

cd /root/x-ui
/usr/local/bin/x-ui setting -port ${PORT} -username admin -password admin
/usr/local/bin/x-ui setting -webBasePath /

echo "✅ Everything is OK! Running X-UI..."
/usr/local/bin/x-ui run
