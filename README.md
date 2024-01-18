# php-fpm-alpine

## work with nginx

```yaml
version: '2'
services:
    nginx:
        image: xiaozhuai/nginx-alpine:latest
        volumes:
            - phpsocket:/var/run/php
            - ./code:/code
            - ./site.conf:/etc/nginx/http.d/default.conf
        ports:
            - 5000:80
        depends_on:
            - php-fpm
    php-fpm:
        image: xiaozhuai/php-fpm-alpine:latest
        volumes:
            - phpsocket:/var/run/php
            - ./code:/code
            - ./zzz_www.conf:/etc/php/php-fpm.d/zzz_www.conf
            - ./zzz_custom.ini:/etc/php/conf.d/zzz_custom.ini

volumes:
    phpsocket:

```
