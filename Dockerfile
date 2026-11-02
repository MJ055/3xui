FROM ubuntu:22.04

RUN apt-get update && apt-get install -y wget curl tar tzdata && rm -rf /var/lib/apt/lists/*
WORKDIR /usr/local/
RUN wget https://github.com/vaxilu/x-ui/releases/latest/download/x-ui-linux-amd64.tar.gz && \
    tar zxvf x-ui-linux-amd64.tar.gz && \
    rm x-ui-linux-amd64.tar.gz && \
    chmod +x x-ui/x-ui x-ui/bin/xray-linux-amd64

COPY start.sh /start.sh
RUN chmod +x /start.sh

WORKDIR /usr/local/x-ui
CMD ["/start.sh"]
