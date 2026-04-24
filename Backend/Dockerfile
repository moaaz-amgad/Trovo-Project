# 1. بنستخدم نسخة PHP الرسمية
FROM php:8.2-fpm

# 2. تحديث وتثبيت مكتبات النظام (حل مشكلة libatomic1)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libatomic1 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 3. تثبيت إضافات PHP
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# 4. تثبيت Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 5. مسار العمل
WORKDIR /var/www

# 6. نسخ الملفات
COPY . .

# 7. تثبيت الحزم
RUN composer install --no-interaction --optimize-autoloader --no-dev

# 8. الصلاحيات
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# 9. المنفذ
EXPOSE 8000

# 10. تشغيل السيرفر
CMD php artisan migrate --force && php artisan serve --host=0.0.0.0 --port=${PORT:-8000}
