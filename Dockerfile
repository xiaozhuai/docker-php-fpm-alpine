FROM alpine:latest

RUN apk --no-cache add \
        curl \
        icu-data-full \
        php83 \
        php83-fpm \
        php83-opcache \
        php83-curl \
        php83-ctype \
        php83-intl \
        php83-fileinfo \
        php83-exif \
        php83-mbstring \
        php83-session \
        php83-iconv \
        php83-common \
        php83-openssl \
        php83-sodium \
        php83-gd \
        php83-xml \
        php83-simplexml \
        php83-xmlreader \
        php83-xmlwriter \
        php83-pdo \
        php83-pdo_mysql \
        php83-pdo_pgsql \
        php83-pdo_sqlite \
        php83-mysqlnd \
        php83-pgsql \
        php83-bz2 \
        php83-zip \
        php83-zlib \
        php83-pcntl \
        php83-posix \
        php83-dom \
        php83-gmp \
        php83-phar \
        php83-bcmath \
        php83-pecl-zstd \
        php83-pecl-ssh2 \
        php83-pecl-yaml \
        php83-pecl-apcu \
        php83-pecl-redis \
        php83-pecl-memcached \
        php83-pecl-xdebug \
    && apk add --no-cache --repository https://dl-cdn.alpinelinux.org/alpine/v3.12/community/ --allow-untrusted gnu-libiconv=1.15-r2 \
    && mkdir -p /var/run/php83 \
    && ln -s /var/log/php83 /var/log/php \
    && ln -s /var/run/php83 /var/run/php \
    && ln -s /usr/share/php83 /usr/share/php \
    && ln -s /usr/lib/php83 /usr/lib/php \
    && ln -s /usr/include/php83 /usr/include/php \
    && ln -s /etc/php83 /etc/php \
    && ln -sf /usr/bin/php83 /usr/bin/php \
    && ln -sf /usr/sbin/php-fpm83 /usr/sbin/php-fpm \
    && rm /etc/php/conf.d/*xdebug*.ini \
    && sed -i "s/;*error_log = .*$/error_log = \/dev\/stderr/" /etc/php/php-fpm.conf \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#    && sed -i "s/user = nobody/user = root/" /etc/php/php-fpm.d/www.conf \
#    && sed -i "s/group = nobody/group = root/" /etc/php/php-fpm.d/www.conf \

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV LD_PRELOAD="/usr/lib/preloadable_libiconv.so php"

ENTRYPOINT ["php-fpm", "-F", "-R"]
