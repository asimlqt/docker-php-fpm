Docker PHP Build
================

Docker image packaging for a PHP + FPM, designed for local development (via `*-dev` tags), and production environments. Available on the [Docker Hub][1].

Usage
-----

The following environment variables are available to allow you to configure how the container will run, and various options within it:

* **PHP_UID**: Allows you to configure the UID of the `php` user within the container. This is set via the container entrypoint. (Default: 1000)
* **PHP_GID**: Allows you to configure the GID of the `php` user within the container. This is set via the container entrypoint. (Default: 1000)
* **PHP_HOME**: Allows you to configure the home directory of the `php` user within the container. (Default: /home/php)
* **PHP_WORKDIR**: This will specify the directory that the CMD will be executed in. This is set via the container entrypoint. (Default: /opt/www)

Notes
-----

Currently the default user ID is 1000, for working on Linux machines with a default user; you should however be able to specify any user.

License
-------

MIT

Contributing
------------

Feel free to open a [pull request][2], or file an [issue][3] on Github. I always welcome contributions as long as they're for the benefit of all (potential) users of this image.

If you're unsure about anything, feel free to ask about it in an issue before you get your heart set on fixing it yourself.

[1]: https://hub.docker.com/r/seeruk/php-fpm/
[2]: https://github.com/SeerUK/docker-php-fpm/pulls
[3]: https://github.com/SeerUK/docker-php-fpm/issues
