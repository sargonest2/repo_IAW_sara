#Dockerfile para crear Bookmedik. Sara
FROM php:8.3-apache

# Instalar cliente MariaDB y extensiones PHP
RUN apt-get update && apt-get install -y mariadb-client && \
    docker-php-ext-install mysqli && \
    docker-php-ext-enable mysqli

# Copiar los archivos de la aplicación
ADD app/bookmedik /var/www/html/

# Exponer el puerto 80
EXPOSE 80

# Definir variables de entorno
ENV DB_HOST=db
ENV DB_USER=admin
ENV DB_PASSWORD=admin
ENV DB_NAME=bookmedik
ENV DB_ROOT_PASSWORD=root

# Añadir scripts y esquema de base de datos
ADD script.sh /usr/local/bin/script.sh
ADD schema.sql /opt

# Dar permisos de ejecución al script
RUN chmod +x /usr/local/bin/script.sh

# Definir comando por defecto
CMD ["/usr/local/bin/script.sh"]

