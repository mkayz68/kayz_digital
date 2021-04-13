FROM php:7.4.12-apache

ENV APACHE_DOCUMENT_ROOT /var/www/html/public

# Apache
COPY conf/vhost.conf /etc/apache2/sites-available/000-default.conf

RUN a2enmod rewrite

RUN docker-php-ext-install pdo pdo_mysql

# Config de PHP

RUN docker-php-ext-install opcache > /dev/null
COPY conf/opcache.ini ${PHP_INI_DIR}/conf.d/opcache.ini

RUN pecl install xdebug-2.9.8 > /dev/null && \
    docker-php-ext-enable xdebug
COPY conf/xdebug.ini ${PHP_INI_DIR}/conf.d/xdebug.ini

RUN cp "${PHP_INI_DIR}/php.ini-development" "${PHP_INI_DIR}/php.ini"
