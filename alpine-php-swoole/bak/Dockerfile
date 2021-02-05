FROM alpine:3.7
MAINTAINER Nick "facelook@163.com"
ENV REFERSHED_AT 2018-03-24
ENV TIMEZONE Asia/Shanghai
ENV PHP_VERSION 7.2.3

LABEL maintainer="developers@graze.com" \
    license="MIT" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vendor="graze" \
    org.label-schema.name="php-alpine" \
    org.label-schema.description="small php image based on alpine" \
    org.label-schema.vcs-url="https://github.com/graze/docker-php-alpine"

# setup remote php packagages
#ADD https://php.codecasts.rocks/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub
#本地托管
ADD ./rsa/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub
RUN set -xe \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && echo "https://php.codecasts.rocks/v3.7/php-7.2" >> /etc/apk/repositories \
    && apk add --update --no-cache --virtual .persistent-deps \
    ca-certificates bash  wget curl vim zip unzip tar \
    iproute2 openssh-client libmemcached-libs libevent libssl1.0 libressl \
    musl yaml \
    php7 php7-gd php7-common php7-apcu php7-bcmath php7-ctype php7-curl php7-dom php7-iconv php7-intl php7-json php7-openssl \
    php7-opcache php7-mbstring php7-memcached php7-mysqlnd php7-mysqli php7-pcntl php7-pgsql php7-pdo_mysql php7-pdo_pgsql php7-pdo_sqlite \
    php7-phar php7-posix php7-session php7-soap php7-sockets php7-sodium php7-xml php7-xmlreader php7-zip php7-zlib php7-redis
    # 安装 Composer，PHP 用来管理依赖关系的工具
    #&& curl -sS https://getcomposer.org/installer \
    #    | php7 -- --install-dir=/usr/bin --filename=composer \
    #&& apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --allow-untrusted \
    #gnu-libiconv

#时区配置
RUN set -x \
    && apk add tzdata \
    && ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone

ENV PHP_INI_DIR /etc/php7
ENV PHP_CLI_DIR /usr/bin/php7
ENV PHP_CLI_DIR_CONFIG /usr/bin/php-config7
ENV PHPIZE_DEPS \
        autoconf file g++ gcc libc-dev libmcrypt-dev make pkgconf re2c php7-dev php7-pear \
        yaml-dev libevent-dev openssl-dev \
        hiredis-dev linux-headers zlib-dev gmp-dev pcre-dev icu-dev

RUN ln -s /usr/bin/php7 /usr/bin/php
RUN ln -s /usr/bin/phpize7 /usr/bin/phpize

#安装swoole扩展
ENV PHP_EXT_SWOOLE=swoole-1.10.3

RUN set -xe \
    && apk add --virtual .phpize-deps \
        $PHPIZE_DEPS \
    && pecl update-channels pecl.php.net \
    && pecl install $PHP_EXT_SWOOLE \
    && apk del .phpize-deps

#使用本地PHP配置
ADD conf/php.ini $PHP_INI_DIR/php.ini

#删除安装库
RUN apk del tzdata \
    && rm -rf /var/cache/apk/* \
    && echo "done"

WORKDIR /home

EXPOSE 9501

CMD ["/bin/sh"]
# 启动swoole server
#CMD ["php","src/server","start"]