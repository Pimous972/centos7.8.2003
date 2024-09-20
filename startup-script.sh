#!/bin/bash

# Arreter le script si besoin
set -e

echo "Conteneur démarré avec succès"

mkdir -p /tmp/packages

yum install -y --nogpgcheck https://rpms.remirepo.net/enterprise/remi-release-7.rpm

echo "Importation des dépendances POSTGRESQL"
yum install -y  --nogpgcheck https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm

yum clean all  --nogpgcheck && yum makecache --nogpgcheck

echo "Importation des dépendances PHP74"
yumdownloader -y  --resolve --destdir=/tmp/packages/php74 php74-php php74-cli php74-php-ldap php74-json php74-xml php74-mbstring php74-zip php74-gd php74-pgsql php74-mysql

echo "Importation des dépendances PHP8.2"
yumdownloader -y  --resolve --destdir=/tmp/packages/php82 php82-php php82-cli php82-php-ldap php82-json php82-xml php82-mbstring php82-zip php82-gd php82-pgsql php82-mysql

echo "Importation des dépendances PHP8.3"
yumdownloader -y  --resolve --destdir=/tmp/packages/php83 php83-php php83-cli php83-php-ldap php83-json php83-xml php83-mbstring php83-zip php83-gd php83-pgsql php83-mysql


echo "Importation des dépendances postgresql13"
yumdownloader -y  --resolve  --destdir=/tmp/packages/postgresql13 postgresql13-libs postgresql13 postgresql13-server

echo "Importation des dépendances postgresql14"
yumdownloader -y  --resolve  --destdir=/tmp/packages/postgresql14 postgresql14-libs postgresql14 postgresql14-server

echo "Importation des dépendances postgresql15"
yumdownloader -y  --resolve  --destdir=/tmp/packages/postgresql15 postgresql15-libs postgresql15 postgresql15-server

echo "Importation des dépendances mariadb"
yumdownloader -y  --resolve  --destdir=/tmp/packages/mariadb-10.11.9 MariaDB-server-10.11.9 MariaDB-client-10.11.9 MariaDB-common-10.11.9 MariaDB-compat-10.11.9

echo "Importation des dépendances mariadb"
yumdownloader -y  --resolve  --destdir=/tmp/packages/mariadb-10.5.9 MariaDB-server-10.5.9 MariaDB-client-10.5.9 MariaDB-common-10.5.9 MariaDB-compat-10.5.9

echo "Fin"

chmod 777 -R /tmp

cd /tmp/

tar -cvzf  packages.tar.gz packages

exec /bin/bash
