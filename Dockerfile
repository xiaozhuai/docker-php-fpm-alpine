FROM alpine:latest

RUN apk --no-cache add \
        php7 \
        php7-fpm \
        php7-opcache \
        php7-curl \
        php7-ctype \
        php7-intl \
        php7-fileinfo \
        php7-exif \
        php7-mbstring \
        php7-session \
        php7-iconv \
        php7-json \
        php7-yaml \
        php7-openssl \
        php7-sodium \
        php7-imagick \
        php7-gd \
        php7-xml \
        php7-simplexml \
        php7-xmlreader \
        php7-xmlwriter \
        php7-pdo \
        php7-pdo_mysql \
        php7-pdo_pgsql \
        php7-pdo_sqlite \
        php7-mysqlnd \
        php7-pgsql \
        php7-apcu \
        php7-redis \
        php7-memcached \
        php7-bz2 \
        php7-zip \
        php7-zlib \
        php7-pcntl \
        php7-posix \
        php7-dom \
        php7-gmp \
        php7-phar \
        php7-bcmath \
        php7-pecl-xdebug \
        curl \
    && rm /etc/php7/conf.d/*xdebug*.ini \
    && sed -i "s/;*error_log = .*$/error_log = \/dev\/stderr/" /etc/php7/php-fpm.conf \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && apk --no-cache --allow-untrusted --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ add gnu-libiconv

#    && sed -i "s/user = nobody/user = root/" /etc/php7/php-fpm.d/www.conf \
#    && sed -i "s/group = nobody/group = root/" /etc/php7/php-fpm.d/www.conf \

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

ENTRYPOINT ["php-fpm7", "-F", "-R"]
