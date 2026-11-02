#!/bin/bash

# اگر پورت توسط Lucity مشخص نشده بود، پیش‌فرض 8080 باشد
PORT=${PORT:-8080}

echo "🚀 Starting X-UI on port ${PORT}..."

# ۱. چک کردن وجود فایل‌ها در لاگ و دادن دسترسی اجرایی به آن‌ها
ls -lh /usr/local/bin/x-ui
ls -lh /root/x-ui/bin/xray-linux-amd64
chmod +x /usr/local/bin/x-ui
chmod +x /root/x-ui/bin/xray-linux-amd64

# ۲. تنظیم پورت در فایل کانفیگ (طبق کد اولیه خودتان)
mkdir -p /etc/x-ui
cat > /etc/x-ui/config.json << EOF
{
  "webPort": ${PORT},
  "webBasePath": "/",
  "webListen": "0.0.0.0",
  "logLevel": "info"
}
EOF

# ۳. رفتن به پوشه اصلی برنامه (معادل WorkingDirectory=/root/x-ui)
cd /root/x-ui

# ۴. تنظیم پورت پنل در دیتابیس (برای اطمینان از باز شدن روی پورت Lucity)
/usr/local/bin/x-ui setting -port ${PORT}

echo "✅ Everything is OK! Running X-UI..."

# ۵. اجرای برنامه (معادل ExecStart=/usr/local/bin/x-ui run)
/usr/local/bin/x-ui run
