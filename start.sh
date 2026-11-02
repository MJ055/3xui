#!/bin/bash

PORT=${PORT:-8080}

echo "🚀 Preparing X-UI on port ${PORT}..."

if [ ! -d "/usr/local/x-ui" ]; then
    echo "📦 X-UI not found! Downloading and installing..."
    wget -q -O /tmp/x-ui-linux-amd64.tar.gz https://github.com/vaxilu/x-ui/releases/latest/download/x-ui-linux-amd64.tar.gz
    
    tar zxvf /tmp/x-ui-linux-amd64.tar.gz -C /usr/local/
    rm -f /tmp/x-ui-linux-amd64.tar.gz
   
    chmod +x /usr/local/x-ui/x-ui /usr/local/x-ui/bin/xray-linux-amd64
fi

cd /usr/local/x-ui

./x-ui setting -port ${PORT} -username admin -password admin

echo "✅ Starting X-UI Panel..."

./x-ui
