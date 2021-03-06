FROM ubuntu:xenial
MAINTAINER Elliot Wright <hello@elliotdwright.com>

COPY provisioning/docker-entrypoint.sh /opt/php-setup/docker-entrypoint.sh

ENV GOSU_VERSION 1.10
ENV PHP_UID 1000
ENV PHP_GID 1000
ENV PHP_HOME /home/php
ENV PHP_WORKDIR /opt/www

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git-core \
        language-pack-en-base \
        openssh-client \
        software-properties-common \
        wget \
    && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    && LC_ALL=en_US.UTF-8 apt-add-repository ppa:ondrej/php \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        imagemagick \
        php7.0 \
        php7.0-apcu \
        php7.0-bz2 \
        php7.0-cli \
        php7.0-common \
        php7.0-curl \
        php7.0-dev \
        php7.0-fpm \
        php7.0-gd \
        php7.0-intl \
        php7.0-json \
        php7.0-mbstring \
        php7.0-mcrypt \
        php7.0-mysql \
        php7.0-pgsql \
        php7.0-xml \
        php7.0-zip \
        php-amqp \
        php-apcu \
        php-imagick \
        php-memcache \
        php-memcached \
        php-redis \
        php-xdebug \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /run/php \
    && chmod +x /opt/php-setup/docker-entrypoint.sh

# Configure PHP
RUN set -x \
    && sed -i 's/user\ =\ www-data/user\ =\ php/g' /etc/php/7.0/fpm/pool.d/www.conf \
    && sed -i 's/group\ =\ www-data/group\ =\ php/g' /etc/php/7.0/fpm/pool.d/www.conf \
    && sed -i 's/listen.owner\ =\ www-data/listen.owner\ =\ php/g' /etc/php/7.0/fpm/pool.d/www.conf \
    && sed -i 's/listen.group\ =\ www-data/listen.group\ =\ php/g' /etc/php/7.0/fpm/pool.d/www.conf \
    && sed -i 's/listen\ =\ \/run\/php\/php7.0-fpm\.sock/listen\ =\ [::]:9000/g' /etc/php/7.0/fpm/pool.d/www.conf \
    && sed -i 's/;daemonize\ =\ yes/daemonize\ =\ no/g' /etc/php/7.0/fpm/php-fpm.conf \
    && echo "opcache.enable = 1" >> /etc/php/7.0/mods-available/opcache.ini \
    && echo "opcache.fast_shutdown = 1" >> /etc/php/7.0/mods-available/opcache.ini \
    && echo "opcache.interned_strings_buffer = 16" >> /etc/php/7.0/mods-available/opcache.ini \
    && echo "opcache.max_accelerated_files = 7963" >> /etc/php/7.0/mods-available/opcache.ini \
    && echo "opcache.memory_consumption = 128" >> /etc/php/7.0/mods-available/opcache.ini \
    && echo "opcache.revalidate_freq = 0" >> /etc/php/7.0/mods-available/opcache.ini \
    && echo "xdebug.remote_enable = on" >> /etc/php/7.0/mods-available/xdebug.ini \
    && echo "xdebug.remote_connect_back = on" >> /etc/php/7.0/mods-available/xdebug.ini \
    && echo "xdebug.idekey = \"docker\"" >> /etc/php/7.0/mods-available/xdebug.ini \
    && echo "xdebug.profiler_enable = 0" >> /etc/php/7.0/mods-available/xdebug.ini \
    && echo "xdebug.profiler_output_dir = /opt/www/debug" >> /etc/php/7.0/mods-available/xdebug.ini \
    && echo "xdebug.profiler_enable_trigger = 1" >> /etc/php/7.0/mods-available/xdebug.ini

EXPOSE 9000

ENTRYPOINT ["/opt/php-setup/docker-entrypoint.sh"]

CMD ["/usr/sbin/php-fpm7.0"]
