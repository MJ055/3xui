#!/bin/bash

# تنظیم پورت پیش‌فرض
PORT=${PORT:-8080}

echo "🚀 Preparing 3X-UI on port ${PORT}..."

# ۱. بررسی و نصب ابزارهای دانلود (curl و tar) در صورت نبودن روی سرور
if ! command -v curl &> /dev/null; then
    echo "🔧 Installing required tools (curl, tar)..."
    apt-get update -y && apt-get install -y curl wget tar ca-certificates tzdata || apk add --no-cache curl wget tar ca-certificates tzdata
fi

# ۲. دانلود و نصب 3x-ui (نسخه سنایی) با استفاده از curl
if [ ! -d "/usr/local/x-ui" ]; then
    echo "📦 3X-UI not found! Downloading and installing..."
    
    curl -L -o /tmp/x-ui-linux-amd64.tar.gz https://github.com/MHSanaei/3x-ui/releases/latest/download/x-ui-linux-amd64.tar.gz
    
    mkdir -p /usr/local/
    tar zxvf /tmp/x-ui-linux-amd64.tar.gz -C /usr/local/
    rm -f /tmp/x-ui-linux-amd64.tar.gz
    
    chmod +x /usr/local/x-ui/x-ui /usr/local/x-ui/bin/*
fi

# ۳. رفتن به پوشه برنامه و اعمال تنظیمات پورت و یوزر/پسورد
cd /usr/local/x-ui

./x-ui setting -port ${PORT} -username admin -password admin
./x-ui setting -webBasePath /

echo "✅ Starting 3X-UI Panel on port ${PORT}..."

# ۴. اجرای پنل
./x-ui
