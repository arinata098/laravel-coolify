# Gunakan PHP CLI 8.2 sebagai base image
FROM php:8.2-cli

# Perbarui sistem dan instal dependensi yang diperlukan
RUN apt-get update -y && apt-get install -y \
    libonig-dev \
    libpq-dev \
    unzip \
    && docker-php-ext-install pdo mbstring

# Instal Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set direktori kerja
WORKDIR /app

# Salin semua file ke dalam container
COPY . /app

# Jalankan Composer untuk menginstal dependensi aplikasi
RUN composer install --no-dev --optimize-autoloader

# Ekspos port untuk server
EXPOSE 8000

# Jalankan aplikasi menggunakan format JSON CMD
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
