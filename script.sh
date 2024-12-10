
#!/bin/bash

# Esperar a que el servicio MySQL esté listo
while ! mysql -u ${DB_USER} -p${DB_PASSWORD} -h ${DB_HOST} -e ";" ; do
    echo "Esperando a que MySQL esté disponible..."
    sleep 1
done    

# Crear la base de datos si no existe
mysql -u ${DB_USER} -p${DB_PASSWORD} -h ${DB_HOST} -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"

# Importar esquema de base de datos
mysql -u ${DB_USER} -p${DB_PASSWORD} -h ${DB_HOST} ${DB_NAME} < /opt/schema.sql

# Iniciar Apache
apache2ctl -D FOREGROUND

#dar permisos a www-data
chown -R www-data:www-data /var/www/html/bookmedik
chmod -R 755 /var/www/html/bookmedik
