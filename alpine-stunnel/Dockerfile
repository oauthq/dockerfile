FROM alpine:latest
MAINTAINER Nick "facelook@163.com"
LABEL Maintainer="ouathq.com <facelook@163.com>" \
      license="MIT" \
      version="1.0" \
      Description="Lightweight container with Stunnel4 based on Alpine Linux." \
      vcs-url="https://github.com/oauthq/dockerfile"

ENV REFERSHED_AT 2020-02-03
ENV TIMEZONE Asia/Shanghai

RUN set -xe \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk add --update --no-cache --virtual .persistent-deps \
    ca-certificates curl vim gettext libintl \
    nginx  openssl stunnel \
    iproute2 \
    && echo "done"

#时区配置
RUN set -x \
    && apk add tzdata \
    && ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

RUN adduser -S www-data -G www-data -u 82

RUN set -x \
 && mkdir -p /var/run/stunnel /var/log/stunnel \
 && chown -vR stunnel:stunnel /var/run/stunnel /var/log/stunnel

ADD ./conf/stunnel* /etc/stunnel/
ADD ./conf/nginx.conf /etc/nginx/nginx.conf

#删除安装库
RUN rm -rf /var/cache/apk/* \
    && echo "done"

#运行设置home 目录 www-data 权限
ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

WORKDIR /home

#http,websocket
EXPOSE 8000 80 443

STOPSIGNAL SIGTERM

CMD ["/bin/sh", "/entrypoint.sh"]