FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# نصب پیش‌نیازها
RUN apt-get update && \
    apt-get install -y wget curl tar tzdata ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# دانلود 3x-ui و قرار دادن فایل‌ها دقیقاً در مسیر /root/x-ui و /usr/local/bin/x-ui
WORKDIR /root/
RUN curl -L -o x-ui-linux-amd64.tar.gz https://github.com/MHSanaei/3x-ui/releases/latest/download/x-ui-linux-amd64.tar.gz && \
    tar zxvf x-ui-linux-amd64.tar.gz && \
    rm -f x-ui-linux-amd64.tar.gz && \
    cp /root/x-ui/x-ui /usr/local/bin/x-ui && \
    chmod +x /usr/local/bin/x-ui /root/x-ui/x-ui /root/x-ui/bin/*

# کپی کردن فایل استارت
COPY start.sh /start.sh
RUN chmod +x /start.sh

WORKDIR /root/x-ui
CMD ["/start.sh"]
