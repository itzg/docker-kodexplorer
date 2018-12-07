FROM php:7.2-apache

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

ADD https://github.com/kalcaddle/KodExplorer/archive/4.36.tar.gz /tmp/kodexplorer.tgz

RUN tar -C /var/www/html -xvf  /tmp/kodexplorer.tgz --strip-components=1 && \
    rm /tmp/kodexplorer.tgz && \
    chmod -R 777 /var/www/html

VOLUME ["/var/www/html/data"]