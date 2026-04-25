# 1. استخدم نسخة CLI عشان نقدر نشغل السيرفر المدمج
FROM php:8.4-cli

# 2. طب المكتبات الأساسية للنظام ولارفيل
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

# 3. نزل Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 4. حدد مسار العمل وانسخ الكود
WORKDIR /var/www
COPY . .

# 5. نزل الـ Dependencies ونضف الـ Cache
RUN composer install --no-dev --optimize-autoloader

# 6. ظبط الصلاحيات عشان ريلواي يقدر يكتب في الملفات
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache
RUN chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# 7. السطر ده هو اللي هيخلي السيرفر يقوم وما يعملش Crash
# هيعمل migrate الأول وبعدين يشغل السيرفر على البورت اللي ريلواي بيدهولك
CMD php artisan migrate --force && php artisan serve --host=0.0.0.0 --port=${PORT:-8000}
