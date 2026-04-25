FROM php:8.4-cli

# 1. تثبيت المكتبات الأساسية للنظام ولارفيل
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

# 2. تنزيل Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 3. تحديد مكان الكود ونسخ الملفات
WORKDIR /var/www
COPY . .

# 4. تنزيل مكتبات المشروع (Vendors)
RUN composer install --no-dev --optimize-autoloader

# 5. ضبط صلاحيات المجلدات عشان متبقاش Read-only
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache
RUN chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# 6. السطر القاضي: تشغيل السيرفر مباشرة على البورت بتاع ريلواي
# ملحوظة: شلنا الـ migrate عشان متوقعش السيرفر وهنعملها يدوي
CMD php artisan serve --host=0.0.0.0 --port=${PORT:-8080}
