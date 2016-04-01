FROM php:5.6-fpm

RUN apt-get update \
    && apt-get install -y git zlibc zlib1g zlib1g-dev libicu52 libicu-dev g++ libssl-dev \
    libmemcached-dev libmcrypt-dev ssh --no-install-recommends \
    && rm -r /var/lib/apt/lists/*
RUN docker-php-ext-configure mbstring
RUN docker-php-ext-install mbstring zip intl bcmath pdo_mysql mcrypt
RUN pecl install mongo && echo extension=mongo.so > /usr/local/etc/php/conf.d/ext-mongo.ini

RUN curl -sS https://getcomposer.org/installer | php -- --version 1.0.0-beta2 --install-dir=/usr/local/bin --filename=composer
RUN composer global require --prefer-dist "fxp/composer-asset-plugin:~1.1.3"

    RUN mkdir -p /opt/icu/icudt52l/ \
    && curl http://source.icu-project.org/repos/icu/data/trunk/tzdata/icunew/2015e/44/le/metaZones.res > /opt/icu/icudt52l/metaZones.res \
    && curl http://source.icu-project.org/repos/icu/data/trunk/tzdata/icunew/2015e/44/le/timezoneTypes.res > /opt/icu/icudt52l/timezoneTypes.res \
    && curl http://source.icu-project.org/repos/icu/data/trunk/tzdata/icunew/2015e/44/le/windowsZones.res > /opt/icu/icudt52l/windowsZones.res \
    && curl http://source.icu-project.org/repos/icu/data/trunk/tzdata/icunew/2015e/44/le/zoneinfo64.res > /opt/icu/icudt52l/zoneinfo64.res

RUN mkdir -p /var/log/php-fpm
RUN ln -sf /dev/stdout /var/log/php-fpm/access.log
RUN ln -sf /dev/stderr /var/log/php-fpm/error.log

CMD ["php-fpm"]