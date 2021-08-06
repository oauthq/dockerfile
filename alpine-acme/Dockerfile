FROM alpine:latest
MAINTAINER Nick "facelook@163.com"
LABEL Maintainer="ouathq.com <facelook@163.com>" \
      license="MIT" \
      version="1.0" \
      Description="Lightweight container with acme based on Alpine Linux." \
      vcs-url="https://github.com/oauthq/dockerfile"

ENV REFERSHED_AT 2020-02-03
ENV TIMEZONE Asia/Shanghai

RUN set -xe \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk add --update --no-cache \
    tzdata curl openssl \
    && curl https://get.acme.sh | sh \
    && ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone \
    && apk del tzdata \
    && rm -rf /var/cache/apk/* \
    && echo "done"

RUN ln -sf /root/.acme.sh/acme.sh /usr/local/bin/acme.sh

WORKDIR /home

CMD ["/bin/sh"]
