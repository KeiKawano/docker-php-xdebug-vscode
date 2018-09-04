FROM php:5.4-apache

# Apacheモジュールインストール
RUN a2enmod rewrite

# PHPモジュールインストール
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install mysql


# Install xdebug for php debugging
RUN apt-get update
RUN apt-get install -y php-pear
RUN pecl install xdebug-2.4.1 \
    && docker-php-ext-enable xdebug
RUN echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug_settings.ini \
    && echo "xdebug.default_enable = 1" >> /usr/local/etc/php/conf.d/xdebug_settings.ini \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/xdebug_settings.ini \
    && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/xdebug_settings.ini \
    # Mac->0 Win->1
    && echo "xdebug.remote_connect_back = 0" >> /usr/local/etc/php/conf.d/xdebug_settings.ini \
    && echo "xdebug.remote_log = /var/log/apache2/xdebug.log" >> /usr/local/etc/php/conf.d/xdebug_settings.ini \
    # [ for Windows ]
    # && echo "xdebug.remote_host = 192.168.22.11" >> /usr/local/etc/php/conf.d/xdebug_settings.ini \
    # [ for Mac ]
    # && echo "xdebug.remote_host = docker.for.mac.localhost" >> /usr/local/etc/php/conf.d/xdebug_settings.ini \
    # [ for Mac ] need 'sudo ifconfig lo0 alias 10.254.254.254'
    # && echo "xdebug.remote_host = 10.254.254.254" >> /usr/local/etc/php/conf.d/xdebug_settings.ini \
    && echo 'xdebug.remote_host = "host.docker.internal"' >> /usr/local/etc/php/conf.d/xdebug_settings.ini \
    && echo "xdebug.remote_port=9001" >> /usr/local/etc/php/conf.d/xdebug_settings.ini

# php設定
RUN echo '\
date.timezone = "Asia/Tokyo"\n\
memory_limit = -1\n\
' >> /usr/local/etc/php/php.ini

# PHPのログを出力
# error_log = /dev/stderr\n\
RUN echo '\
log_errors = On\n\
error_log = /var/log/apache2/php.log\n\
error_reporting = E_ALL\n\
display_errors = On\n\
' >> /usr/local/etc/php/conf.d/docker.ini

# apacheのログを出力
RUN echo '\
CustomLog /var/log/apache2/access.log combined \n\
ErrorLog /var/log/apache2/error.log\n\
LogLevel warn\n\
' >> /etc/apache2/conf-enabled/log.conf