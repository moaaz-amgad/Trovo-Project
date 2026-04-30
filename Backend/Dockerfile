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

# 5. ضبط صلاحيات المجلدات
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache
RUN chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# 6. تحسين الأداء (Optimization)
# ملحوظة: بنعمل clear الأول عشان نضمن مفيش داتا قديمة
RUN php artisan config:clear && \
    php artisan route:clear && \
    php artisan view:clear && \
    php artisan optimize

# 7. تشغيل السيرفر
CMD php artisan serve --host=0.0.0.0 --port=${PORT:-8080}
