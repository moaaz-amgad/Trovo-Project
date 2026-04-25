FROM php:8.4-cli

# تثبيت الإضافات
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

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www
COPY . .

RUN composer install --no-dev --optimize-autoloader

# ضبط الصلاحيات
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache
RUN chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# التعديل الجوهري هنا: هنشغل السيرفر مباشرة
# الـ Migrate اعمله يدوي من ريلواي مرة واحدة عشان ميوقعش السيرفر كل شوية
CMD php artisan serve --host=0.0.0.0 --port=${PORT:-8000}
