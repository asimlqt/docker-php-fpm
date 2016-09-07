#!/bin/bash

PWD=$(pwd)

cd "${PWD}/5.6/"
docker build -t seeruk/php-fpm:5.6 .

cd "${PWD}/5.6-dev/"
docker build -t seeruk/php-fpm:5.6-dev .

cd "${PWD}/7.0-dev/"
docker build -t seeruk/php-fpm:7.0-dev .

cd "${PWD}"
docker push seeruk/php-fpm:5.6
docker push seeruk/php-fpm:5.6-dev
docker push seeruk/php-fpm:7.0-dev
