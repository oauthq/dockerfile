FROM alpine:latest
MAINTAINER Nick "facelook@163.com"
LABEL Maintainer="ouathq.com <facelook@163.com>" \
      license="MIT" \
      version="1.0" \
      Description="Lightweight container with Nginx 1.8 based on Alpine Linux." \
      vcs-url="https://github.com/oauthq/dockerfile"

ENV REFERSHED_AT 2020-02-03
ENV TIMEZONE Asia/Shanghai

RUN set -xe \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk add --update --no-cache \
    tzdata  nginx iproute2 \
    && ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone \
    && apk del tzdata \
    && rm -rf /var/cache/apk/* \
    && echo "done"

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

COPY conf/nginx.conf /etc/nginx/nginx.conf

#运行设置home 目录 www-data 权限
ADD ./script/run.sh /
RUN chmod +x /run.sh
RUN sh /run.sh && rm /run.sh

WORKDIR /home

#http,websocket
EXPOSE 80 443

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]