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
        php7.0 php7.0-cli php7.0-common php7.0-curl php7.0-dev php7.0-fpm php7.0-gd \
        php7.0-intl php7.0-json php7.0-mcrypt php7.0-mysql php-apcu php-imagick php-memcached \
        php-xdebug && \
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
    echo "zend_extension = xdebug.so" >> /etc/php/7.0/mods-available/xdebug.ini.template && \
    echo "xdebug.remote_enable = on" >> /etc/php/7.0/mods-available/xdebug.ini.template && \
    echo "xdebug.remote_connect_back = on" >> /etc/php/7.0/mods-available/xdebug.ini.template && \
    echo "xdebug.idekey = \"docker\"" >> /etc/php/7.0/mods-available/xdebug.ini.template

EXPOSE 9000

CMD /bin/bash -c "envsubst < /etc/php/7.0/mods-available/xdebug.ini.template > /etc/php/7.0/mods-available/xdebug.ini && /usr/sbin/php-fpm7.0"
