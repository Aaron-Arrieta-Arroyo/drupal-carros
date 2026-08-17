FROM drupal:11-apache

RUN apt-get update && apt-get install -y \
    libpq-dev \
    unzip \
    git \
    && docker-php-ext-install pdo pdo_pgsql \
    && rm -rf /var/lib/apt/lists/*

COPY drupal/composer.json drupal/composer.lock /opt/drupal/
WORKDIR /opt/drupal
RUN composer install --no-dev --optimize-autoloader --no-interaction --prefer-dist || true

COPY drupal/web /var/www/html
COPY drupal/vendor /opt/drupal/vendor

RUN chown -R www-data:www-data /var/www/html \
    && mkdir -p /var/www/html/sites/default/files \
    && chmod -R 777 /var/www/html/sites/default/files

ENV APACHE_DOCUMENT_ROOT /var/www/html
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

EXPOSE 80
