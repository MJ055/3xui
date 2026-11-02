#!/bin/bash

PORT=${PORT:-8080}

echo "🚀 Starting X-UI setup on port ${PORT}..."
echo "👤 User: $(whoami) | Dir: $(pwd)"

# ۱. اگر فایل‌ها در مسیر /root/x-ui و /usr/local/bin/x-ui نیستند، همین‌جا دانلود و نصب کن
if [ ! -f "/usr/local/bin/x-ui" ]  [ ! -d "/root/x-ui" ]; then
    echo "📦 X-UI not found! Downloading and placing files in /root/x-ui ..."
    
    mkdir -p /root /usr/local/bin /tmp
    URL="https://github.com/MHSanaei/3x-ui/releases/latest/download/x-ui-linux-amd64.tar.gz"
    FILE="/tmp/x-ui.tar.gz"

    # دانلود هوشمند با هر ابزاری که روی سرور Lucity نصب باشد (curl یا python یا wget)
    if command -v curl >/dev/null 2>&1; then
        echo "⬇️ Downloading with curl..."
        curl -L -o "$FILE" "$URL"
    elif command -v python3 >/dev/null 2>&1; then
        echo "⬇️ Downloading with python3..."
        python3 -c "import urllib.request; urllib.request.urlretrieve('$URL', '$FILE')"
    elif command -v wget >/dev/null 2>&1; then
        echo "⬇️ Downloading with wget..."
        wget -O "$FILE" "$URL"
    else
        echo "🔧 Installing curl..."
        apt-get update && apt-get install -y curl ca-certificates  apk add --no-cache curl ca-certificates
        curl -L -o "$FILE" "$URL"
    fi

    echo "📂 Extracting files..."
    tar zxvf "$FILE" -C /root/
    rm -f "$FILE"

    # کپی کردن فایل اجرایی دقیقاً به مسیر /usr/local/bin/x-ui
    cp /root/x-ui/x-ui /usr/local/bin/x-ui
    
    # دادن دسترسی اجرایی به فایل‌ها
    chmod +x /usr/local/bin/x-ui
    chmod +x /root/x-ui/x-ui
    chmod +x /root/x-ui/bin/*
fi

# ۲. چک کردن اینکه فایلا درست سرجاشه (طبق دستور شما)
echo "🔍 Checking files:"
ls -lh /usr/local/bin/x-ui
ls -lh /root/x-ui/bin/xray-linux-amd64

# ۳. رفتن به پوشه برنامه (معادل WorkingDirectory=/root/x-ui)
cd /root/x-ui

# ۴. تنظیم پورت پنل و یوزر و پسورد پیش‌فرض (admin / admin)
/usr/local/bin/x-ui setting -port ${PORT} -username admin -password admin
/usr/local/bin/x-ui setting -webBasePath /

echo "✅ Everything is OK! Running X-UI..."

# ۵. اجرای برنامه (معادل ExecStart=/usr/local/bin/x-ui run)
/usr/local/bin/x-ui run
