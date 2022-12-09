FROM alpine:latest

RUN apk --no-cache add \
        php81 \
        php81-fpm \
        php81-opcache \
        php81-curl \
        php81-ctype \
        php81-intl \
        php81-fileinfo \
        php81-exif \
        php81-mbstring \
        php81-session \
        php81-iconv \
        php81-common \
        php81-openssl \
        php81-sodium \
        php81-gd \
        php81-xml \
        php81-simplexml \
        php81-xmlreader \
        php81-xmlwriter \
        php81-pdo \
        php81-pdo_mysql \
        php81-pdo_pgsql \
        php81-pdo_sqlite \
        php81-mysqlnd \
        php81-pgsql \
        php81-bz2 \
        php81-zip \
        php81-zlib \
        php81-pcntl \
        php81-posix \
        php81-dom \
        php81-gmp \
        php81-phar \
        php81-bcmath \
        php81-pecl-uuid \
        php81-pecl-zstd \
        php81-pecl-ssh2 \
        php81-pecl-imagick \
        php81-pecl-yaml \
        php81-pecl-apcu \
        php81-pecl-redis \
        php81-pecl-memcached \
        php81-pecl-xdebug \
        curl \
    && rm /etc/php81/conf.d/*xdebug*.ini \
    && sed -i "s/;*error_log = .*$/error_log = \/dev\/stderr/" /etc/php81/php-fpm.conf \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && apk --no-cache --allow-untrusted --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ add gnu-libiconv

#    && sed -i "s/user = nobody/user = root/" /etc/php81/php-fpm.d/www.conf \
#    && sed -i "s/group = nobody/group = root/" /etc/php81/php-fpm.d/www.conf \

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

ENTRYPOINT ["php-fpm81", "-F", "-R"]
