#!/bin/bash

set -ex

WORKDIR=$(pwd)

cd "${WORKDIR}/5.6/"
docker build -t seeruk/php-fpm:5.6 .

cd "${WORKDIR}/5.6-dev/"
docker build -t seeruk/php-fpm:5.6-dev .

cd "${WORKDIR}/7.0-dev/"
docker build -t seeruk/php-fpm:7.0-dev .

cd "${WORKDIR}/7.1-dev/"
docker build -t seeruk/php-fpm:7.1-dev .

cd "${WORKDIR}"
docker push seeruk/php-fpm:5.6
docker push seeruk/php-fpm:5.6-dev
docker push seeruk/php-fpm:7.0-dev
docker push seeruk/php-fpm:7.1-dev
