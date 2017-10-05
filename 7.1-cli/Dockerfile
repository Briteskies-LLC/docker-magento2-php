# vim:set ft=dockerfile:
FROM php:7.1-cli
MAINTAINER Navarr Barnier <Navarr.Barnier@briteskies.com>
# Don't email me.  I have no idea what I'm doing.

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libxslt1-dev \
        libicu-dev \
        git \
    && docker-php-ext-configure \
        gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install \
        bcmath \
        gd \
        intl \
        mbstring \
        mcrypt \
        hash \
        simplexml \
        pdo \
        pdo_mysql \
        soap \
        xml \
        xsl \
        zip \
        json \
        iconv

# Generic Configuration

ADD docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

COPY conf/php.ini /usr/local/etc/php/

# Install ioncube loader

RUN curl -o ioncube.tar.gz http://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz \
    && tar -xzvf ioncube.tar.gz \
    && mv ioncube/ioncube_loader_lin_7.1.so /usr/local/lib/php/extensions/* \
    && rm -rf ioncube.tar.gz ioncube

ADD conf/ioncube.ini /usr/local/etc/php/conf.d/00-ioncube.ini

# Install Composer

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Deployer

RUN composer global require deployer/deployer \
    && ln -s /root/.composer/vendor/bin/dep /usr/local/bin/dep \
    && ln -s /usr/local/bin/dep /usr/local/bin/deployer

WORKDIR /srv/www
