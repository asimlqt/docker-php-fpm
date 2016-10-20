FROM ubuntu:xenial
MAINTAINER Elliot Wright <hello@elliotdwright.com>

COPY provisioning/docker-entrypoint.sh /opt/php-setup/docker-entrypoint.sh

ENV PHP_UID 1000
ENV PHP_GID 1000
ENV PHP_HOME /home/php
ENV PHP_WORKDIR /opt/www

# Some common PHP settings...
ENV PHP_MEMORY_LIMIT 128M
ENV PHP_POST_MAX_SIZE 8M
ENV PHP_UPLOAD_MAX_FILESIZE 2M

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git-core \
        language-pack-en-base \
        openssh-client \
        software-properties-common \
    && LC_ALL=en_US.UTF-8 apt-add-repository ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        php5.6 \
        php5.6-apcu \
        php5.6-cli \
        php5.6-common \
        php5.6-curl \
        php5.6-dev \
        php5.6-fpm \
        php5.6-gd \
        php5.6-imagick \
        php5.6-intl \
        php5.6-json \
        php5.6-mbstring \
        php5.6-mcrypt \
        php5.6-memcached \
        php5.6-mysql \
        php5.6-xml \
        php5.6-zip \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/app/lists/* \
    && mkdir -p /run/php \
    && chmod +x /opt/php-setup/docker-entrypoint.sh

RUN set -x \
    && sed -i 's/user\ =\ www-data/user\ =\ php/g' /etc/php/5.6/fpm/pool.d/www.conf \
    && sed -i 's/group\ =\ www-data/group\ =\ php/g' /etc/php/5.6/fpm/pool.d/www.conf \
    && sed -i 's/listen.owner\ =\ www-data/listen.owner\ =\ php/g' /etc/php/5.6/fpm/pool.d/www.conf \
    && sed -i 's/listen.group\ =\ www-data/listen.group\ =\ php/g' /etc/php/5.6/fpm/pool.d/www.conf \
    && sed -i 's/listen\ =\ \/run\/php\/php5.6-fpm\.sock/listen\ =\ [::]:9000/g' /etc/php/5.6/fpm/pool.d/www.conf \
    && sed -i 's/;daemonize\ =\ yes/daemonize\ =\ no/g' /etc/php/5.6/fpm/php-fpm.conf \
    && sed -i 's/;date.timezone\ =/date.timezone\ =\ Europe\/London/g' /etc/php/5.6/fpm/php.ini \
    && echo "opcache.enable = 1" >> /etc/php/5.6/mods-available/opcache.ini \
    && echo "opcache.fast_shutdown = 1" >> /etc/php/5.6/mods-available/opcache.ini \
    && echo "opcache.interned_strings_buffer = 16" >> /etc/php/5.6/mods-available/opcache.ini \
    && echo "opcache.max_accelerated_files = 7963" >> /etc/php/5.6/mods-available/opcache.ini \
    && echo "opcache.memory_consumption = 128" >> /etc/php/5.6/mods-available/opcache.ini \
    && echo "opcache.revalidate_freq = 0" >> /etc/php/5.6/mods-available/opcache.ini

EXPOSE 9000

ENTRYPOINT ["/opt/php-setup/docker-entrypoint.sh"]

CMD ["/usr/sbin/php-fpm5.6"]
