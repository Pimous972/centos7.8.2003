#!/bin/bash

# Arreter le script si besoin
set -e

echo "Conteneur démarré avec succès"

mkdir -p /tmp/packages

yum install -y --nogpgcheck https://rpms.remirepo.net/enterprise/remi-release-7.rpm

echo "Importation des dépendances POSTGRESQL"
yum install -y  --nogpgcheck https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm

yum clean all  --nogpgcheck && yum makecache --nogpgcheck

for version in 74 82 83; do
    echo "Importation des dépendances php${version}"
    yumdownloader -y  --resolve --destdir=/tmp/packages/php${version} php${version}-php php${version}-cli php${version}-php-ldap php${version}-json php${version}-xml php${version}-mbstring php${version}-zip php${version}-gd php${version}-pgsql php${version}-mysql
done

for version in 13 14 15; do
    echo "Importation des dépendances postgresql${version} "
    yumdownloader -y  --resolve  --destdir=/tmp/packages/postgresql${version} postgresql${version}-libs postgresql${version} postgresql${version}-server
done;

for version in 10.5.9 10.11.9; do
    echo "Importation des dépendances mariadb${version}"
    yumdownloader -y  --resolve  --destdir=/tmp/packages/mariadb-${version} MariaDB-server-${version} MariaDB-client-${version} MariaDB-common-${version} MariaDB-compat-${version}
done;


yum install httpd -y
chmod 755 -R /tmp
cd /tmp/
tar -cvzf  /var/www/html/packages.tar.gz packages
rm -rfv /tmp/packages
chown apache:apache /var/www/html/ -R
httpd -D FOREGROUND
