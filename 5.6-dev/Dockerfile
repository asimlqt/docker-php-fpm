FROM ubuntu:trusty
MAINTAINER Elliot Wright <elliot@elliotwright.co>

# Install PHP
RUN \
    useradd -u 1000 -m -s /bin/bash php && \
    mkdir -p /opt/www && \
    chown -R php: /opt/www && \
    apt-get update && \
    apt-get install -y language-pack-en-base software-properties-common && \
    LC_ALL=en_US.UTF-8 apt-add-repository ppa:ondrej/php5-5.6 && \
    apt-get update && \
    apt-get install -y \
        php5 php5-apcu php5-cli php5-common php5-curl php5-dev php5-fpm php5-gd php5-imagick \
        php5-intl php5-json php5-mcrypt php5-memcached php5-mysql php5-xdebug && \
    apt-get autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure PHP
RUN \
    sed -i 's/user\ =\ www-data/user\ =\ php/g' /etc/php5/fpm/pool.d/www.conf && \
    sed -i 's/group\ =\ www-data/group\ =\ php/g' /etc/php5/fpm/pool.d/www.conf && \
    sed -i 's/listen.owner\ =\ www-data/listen.owner\ =\ php/g' /etc/php5/fpm/pool.d/www.conf && \
    sed -i 's/listen.group\ =\ www-data/listen.group\ =\ php/g' /etc/php5/fpm/pool.d/www.conf && \
    sed -i 's/listen\ =\ \/var\/run\/php5-fpm\.sock/listen\ =\ [::]:9000/g' /etc/php5/fpm/pool.d/www.conf && \
    sed -i 's/;daemonize\ =\ yes/daemonize\ =\ no/g' /etc/php5/fpm/php-fpm.conf && \
    echo "opcache.enable = 1" >> /etc/php5/mods-available/opcache.ini && \
    echo "opcache.fast_shutdown = 1" >> /etc/php5/mods-available/opcache.ini && \
    echo "opcache.interned_strings_buffer = 16" >> /etc/php5/mods-available/opcache.ini && \
    echo "opcache.max_accelerated_files = 7963" >> /etc/php5/mods-available/opcache.ini && \
    echo "opcache.memory_consumption = 128" >> /etc/php5/mods-available/opcache.ini && \
    echo "opcache.revalidate_freq = 0" >> /etc/php5/mods-available/opcache.ini && \
    echo "zend_extension = xdebug.so" >> /etc/php5/mods-available/xdebug.ini && \
    echo "xdebug.remote_enable = on" >> /etc/php5/mods-available/xdebug.ini && \
    echo "xdebug.remote_connect_back = on" >> /etc/php5/mods-available/xdebug.ini && \
    echo "xdebug.idekey = \"docker\"" >> /etc/php5/mods-available/xdebug.ini && \
    echo "xdebug.profiler_enable = 0" >> /etc/php5/mods-available/xdebug.ini && \
    echo "xdebug.profiler_output_dir = /opt/www/debug" >> /etc/php5/mods-available/xdebug.ini && \
    echo "xdebug.profiler_enable_trigger = 1" >> /etc/php5/mods-available/xdebug.ini

EXPOSE 9000

CMD /bin/bash -c "/usr/sbin/php5-fpm"
