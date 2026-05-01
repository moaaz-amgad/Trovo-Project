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

# 3. تحديد مكان الكود
WORKDIR /var/www

# 4. نسخ ملفات الـ Composer أولاً لتحسين الـ Caching
COPY composer.json composer.lock ./

# 5. تنزيل مكتبات المشروع بدون الـ Dev dependencies
RUN composer install --no-dev --no-scripts --no-autoloader --prefer-dist

# 6. نسخ باقي كود المشروع
COPY . .

# 7. توليد الـ Autoloader وتنفيذ الـ Scripts
RUN composer dump-autoload --optimize

# 8. ضبط صلاحيات المجلدات (مهم جداً للـ Storage)
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache && \
    chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# 9. تنفيذ أوامر تحسين الأداء (Production Optimization)
# بنعمل clear الأول وبعدين cache لكل حاجة
RUN php artisan config:clear && \
    php artisan route:clear && \
    php artisan view:clear && \
    php artisan optimize

# 10. تشغيل السيرفر على البورت الخاص بـ Railway
# ملاحظة: تأكد أن APP_KEY موجود في الـ Variables على ريلواي
CMD php artisan serve --host=0.0.0.0 --port=${PORT:-8080}
