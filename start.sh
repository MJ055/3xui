#!/bin/bash
PORT=${PORT:-8080}
echo "🚀 Starting X-UI on port ${PORT}..."

cd /usr/local/x-ui
# تنظیم پورت بر اساس پورتی که Lucity می‌دهد
./x-ui setting -port ${PORT}

# اجرای برنامه
./x-ui
