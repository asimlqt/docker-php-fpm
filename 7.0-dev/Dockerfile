FROM ubuntu:trusty
MAINTAINER Elliot Wright <elliot@elliotwright.co>

# Install PHP
RUN \
    useradd -u 1000 -m -s /bin/bash php && \
    mkdir -p /run/php && \
    mkdir -p /opt/www && \
    chown -R php: /opt/www && \
    apt-get update && \
    apt-get install -y language-pack-en-base software-properties-common && \
    LC_ALL=en_US.UTF-8 apt-add-repository ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y \
        php7.0 php7.0-bz2 php7.0-cli php7.0-common php7.0-curl php7.0-dev php7.0-fpm php7.0-gd \
        php7.0-intl php7.0-json php7.0-mcrypt php7.0-mysql php7.0-zip php-amqp php-apcu \
        php-imagick php-memcache php-memcached php-redis php-xdebug && \
    apt-get autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure PHP
RUN \
    sed -i 's/user\ =\ www-data/user\ =\ php/g' /etc/php/7.0/fpm/pool.d/www.conf && \
    sed -i 's/group\ =\ www-data/group\ =\ php/g' /etc/php/7.0/fpm/pool.d/www.conf && \
    sed -i 's/listen.owner\ =\ www-data/listen.owner\ =\ php/g' /etc/php/7.0/fpm/pool.d/www.conf && \
    sed -i 's/listen.group\ =\ www-data/listen.group\ =\ php/g' /etc/php/7.0/fpm/pool.d/www.conf && \
    sed -i 's/listen\ =\ \/run\/php\/php7.0-fpm\.sock/listen\ =\ [::]:9000/g' /etc/php/7.0/fpm/pool.d/www.conf && \
    sed -i 's/;daemonize\ =\ yes/daemonize\ =\ no/g' /etc/php/7.0/fpm/php-fpm.conf && \
    echo "opcache.enable = 1" >> /etc/php/7.0/mods-available/opcache.ini && \
    echo "opcache.fast_shutdown = 1" >> /etc/php/7.0/mods-available/opcache.ini && \
    echo "opcache.interned_strings_buffer = 16" >> /etc/php/7.0/mods-available/opcache.ini && \
    echo "opcache.max_accelerated_files = 7963" >> /etc/php/7.0/mods-available/opcache.ini && \
    echo "opcache.memory_consumption = 128" >> /etc/php/7.0/mods-available/opcache.ini && \
    echo "opcache.revalidate_freq = 0" >> /etc/php/7.0/mods-available/opcache.ini && \
    echo "xdebug.remote_enable = on" >> /etc/php/7.0/mods-available/xdebug.ini && \
    echo "xdebug.remote_connect_back = on" >> /etc/php/7.0/mods-available/xdebug.ini && \
    echo "xdebug.idekey = \"docker\"" >> /etc/php/7.0/mods-available/xdebug.ini && \
    echo "xdebug.profiler_enable = 0" >> /etc/php/7.0/mods-available/xdebug.ini && \
    echo "xdebug.profiler_output_dir = /opt/www/debug" >> /etc/php/7.0/mods-available/xdebug.ini && \
    echo "xdebug.profiler_enable_trigger = 1" >> /etc/php/7.0/mods-available/xdebug.ini

EXPOSE 9000

CMD /bin/bash -c "/usr/sbin/php-fpm7.0"
