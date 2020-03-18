FROM php:7.3-fpm

# Install system dependencies
RUN set -ex && \
    apt-get update && \
    apt-get install -qq -y make git zlib1g-dev libaio1 gnupg libpng-dev libfreetype6-dev libjpeg62-turbo-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install PHP extensions
ENV BUILD_PACKAGES="libssh-dev gcc autoconf libc-dev pkg-config"
RUN set -ex && \
    apt-get update && \
    apt-get install -qq -y $BUILD_PACKAGES && \
    apt-get install -y libcurl3-dev libldap2-dev libxml2-dev default-mysql-client libgeoip-dev libmagickwand-dev libzip-dev && \
    pecl install xdebug-2.7.2 geoip-1.1.1 \
        imagick && \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-install bz2 \
            bcmath \
            calendar \
            ctype \
            curl \
            gettext \
            gd \
            intl \
            ldap \
            mbstring \
            mysqli \
            pdo \
            pdo_mysql \
            zip && \
    docker-php-ext-enable bz2 \
            bcmath \
            calendar \
            ctype \
            curl \
            geoip \
            gettext \
            gd \
            intl \
            imagick \
            ldap \
            mbstring \
            mysqli \
            pdo \
            pdo_mysql \
            zip \
            xdebug && \
    apt-get remove --purge -y $BUILD_PACKAGES && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Composer
RUN mv /var/www/html /var/www/public && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# PHP MOD(s) ###############################################################
RUN ln -f -s ${PHP_MODS_DIR}/custom.ini ${PHP_CLI_CONF_DIR}/999-custom.ini && \
    ln -f -s ${PHP_MODS_DIR}/custom.ini ${PHP_CGI_CONF_DIR}/999-custom.ini && \
    ln -f -s ${PHP_MODS_DIR}/custom.ini ${PHP_FPM_CONF_DIR}/999-custom.ini

# CLEAN UP #################################################################
#RUN rm ${PHP_FPM_POOL_DIR}/www.conf && \
#    apt-get clean -y && \
#    apt-get autoclean -y && \
##    apt-get remove -y wget curl && \
#    apt-get autoremove -y && \
#    rm -rf /var/lib/apt/lists/ /var/lib/log/ /tmp/ /var/tmp/

# FILES (it overrides originals)
ADD conf.d/custom.ini ${PHP_MODS_DIR}/custom.ini
ADD fpm/php-fpm.conf ${PHP_FPM_DIR}/php-fpm.conf
RUN cd /srv && mkdir -p vendor/bin && touch vendor/bin/drush && ln -Ls /srv/vendor/bin/drush /usr/local/bin/drush

# WORKDIR
WORKDIR /srv
