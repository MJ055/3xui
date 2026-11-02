#!/bin/bash

PORT=${PORT:-8080}

echo "🚀 Starting X-UI on port ${PORT}..."

# ۱. چک کردن اینکه فایل‌ها سر جایشان هستند
ls -lh /usr/local/bin/x-ui
ls -lh /root/x-ui/bin/xray-linux-amd64

# ۲. رفتن به پوشه اصلی برنامه (معادل WorkingDirectory=/root/x-ui)
cd /root/x-ui

# ۳. تنظیم پورت پنل و یوزر و پسورد پیش‌فرض (admin / admin)
/usr/local/bin/x-ui setting -port ${PORT} -username admin -password admin
/usr/local/bin/x-ui setting -webBasePath /

echo "✅ Everything is OK! Running X-UI..."

# ۴. اجرای برنامه (معادل ExecStart=/usr/local/bin/x-ui run)
/usr/local/bin/x-ui run
