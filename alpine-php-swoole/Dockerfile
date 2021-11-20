FROM alpine:latest
MAINTAINER Nick "facelook@163.com"
LABEL Maintainer="ouathq.com <facelook@163.com>" \
      license="MIT" \
      version="1.0" \
      Description="Lightweight container with PHP-FPM 7.4.14 based on Alpine Linux." \
      vcs-url="https://github.com/oauthq/dockerfile"

ENV REFERSHED_AT 2020-02-03
ENV TIMEZONE Asia/Shanghai
ENV PHP_VERSION 7.4

RUN set -xe \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk add --update --no-cache --virtual .persistent-deps \
    ca-certificates wget curl vim zip unzip tar \
    iproute2 openssh-client libmemcached-libs libevent libressl \
    musl yaml \
    php7 php7-dev php7-fpm php7-gd php7-common php7-apcu php7-bcmath php7-ctype php7-curl php7-dom php7-iconv php7-intl php7-json php7-openssl \
    php7-opcache php7-mbstring php7-memcached php7-mysqlnd php7-mysqli php7-pcntl php7-pgsql php7-pdo_mysql php7-pdo_pgsql php7-pdo_sqlite \
    php7-phar php7-posix php7-session php7-soap php7-sockets php7-sodium php7-xml php7-xmlreader php7-zip php7-zlib php7-redis php7-pear \
    #安装 Composer，PHP 用来管理依赖关系的工具
    && curl -sS https://getcomposer.org/installer \
        | php7 -- --install-dir=/usr/bin --filename=composer \
    && apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --allow-untrusted \
    gnu-libiconv \
    && echo "done"

#时区配置
RUN set -x \
    && apk add tzdata \
    && ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone

ENV PHP_INI_DIR /etc/php7
ENV PHP_CLI_DIR /usr/bin/php7
ENV PHP_CLI_DIR_CONFIG /usr/bin/php-config7
ENV PHPIZE_DEPS \
        autoconf file g++ gcc libc-dev libmcrypt-dev make pkgconf re2c \
        yaml-dev libevent-dev openssl-dev \
        hiredis-dev linux-headers zlib-dev gmp-dev pcre-dev icu-dev

RUN set -xe \
    && apk add --virtual .phpize-deps $PHPIZE_DEPS

#安装php7-wxwork-finance-sdk
#ADD extend/php7-wxwork-finance-sdk /home/php7-wxwork-finance-sdk
#ADD script/wxwork.sh /
#RUN chmod +x /wxwork.sh && /bin/sh /wxwork.sh

#安装swoole扩展
ENV PHP_EXT_SWOOLE=swoole-4.6.2

RUN pecl update-channels pecl.php.net \
    && cd /tmp \
    && mkdir -p /tmp/$PHP_EXT_SWOOLE \
    && wget -O ${PHP_EXT_SWOOLE}.tgz https://github.com/swoole/swoole-src/archive/v4.6.2.tar.gz \
    && tar -xf ${PHP_EXT_SWOOLE}.tgz -C /tmp/$PHP_EXT_SWOOLE --strip-components=1 \
    && cd /tmp/$PHP_EXT_SWOOLE \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && rm -rf /tmp/${PHP_EXT_SWOOLE}* \
    && apk del .phpize-deps


#使用本地PHP配置
ADD conf/cacert.pem $PHP_INI_DIR/cacert.pem
ADD conf/php.ini $PHP_INI_DIR/php.ini

#删除安装库
RUN rm -rf /var/cache/apk/* \
    && echo "done"

WORKDIR /home

EXPOSE 9501

CMD ["/bin/sh"]
# 启动swoole server
#CMD ["php","src/server","start"]
