FROM php:8.4-cli

# تثبيت المكتبات الأساسية
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git \
    curl \
    libzip-dev \
    && docker-php-ext-install pdo_mysql zip exif pcntl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# تنزيل Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www
COPY . .

# تنزيل مكتبات المشروع
RUN composer install --no-dev --optimize-autoloader

# صلاحيات المجلدات
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache
RUN chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# السطر ده هو "الزتونة": بيخلي لارفيل يسمع للبورت اللي ريلواي بيبعته ديناميكياً
CMD php artisan serve --host=0.0.0.0 --port=${PORT:-8080}
