#!/bin/bash

set -e

echo "Conteneur démarré avec succès"


mkdir -p /tmp/packages

echo "Installation des dépôts PHP"
yum install -y --nogpgcheck https://rpms.remirepo.net/enterprise/remi-release-7.rpm

echo "Installation des dépôts POSTGRESQL"
yum install -y  --nogpgcheck https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm

echo "Installation des dépôts GITLAB"
curl -s https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh | bash

yum clean all  --nogpgcheck && yum makecache --nogpgcheck

for version in 74 82 83; do
    echo "Importation des dépendances php${version}"
    yumdownloader -y  --resolve --destdir=/tmp/packages/php${version} php${version}-php php${version}-php-intl  php${version}-php-cli php${version}-php-ldap php${version}-php-json php${version}-php-xml php${version}-php-mbstring php${version}-php-zip php${version}-php-gd php${version}-php-pgsql php${version}-php-mysql php${version}-php-common php${version}-php-imagick
done

for version in 9 10 11 12 13 14 15; do
    echo "Importation des dépendances postgresql${version} "
    yumdownloader -y  --resolve  --destdir=/tmp/packages/postgresql${version} postgresql${version}-libs postgresql${version} postgresql${version}-server postgresql${version}-contrib libpq5
done;

for version in 10.1.48 10.2.44 10.3.39 10.4.34 10.5.9 10.11.9; do
    echo "Importation des dépendances mariadb${version}"
    yumdownloader -y  --resolve  --destdir=/tmp/packages/mariadb-${version} MariaDB-server-${version} MariaDB-client-${version} MariaDB-common-${version} MariaDB-compat-${version}
done;

yumdownloader -y  --resolve  --destdir=/tmp/packages/gitlab-runner gitlab-runner-17.4.0-1.x86_64

yum install wget -y

wget -P /tmp/packages/pgadmin4 https://pgadmin-archive.postgresql.org/pgadmin4/yum/redhat/rhel-7Server-x86_64/pgadmin4-web-6.21-1.el7.noarch.rpm
wget -P /tmp/packages/pgadmin4 https://pgadmin-archive.postgresql.org/pgadmin4/yum/redhat/rhel-7Server-x86_64/pgadmin4-server-6.21-1.el7.x86_64.rpm
wget -P /tmp/packages/pgadmin4 https://pgadmin-archive.postgresql.org/pgadmin4/yum/redhat/rhel-7Server-x86_64/pgadmin4-python3-mod_wsgi-4.7.1-2.el7.x86_64.rpm
wget -P /tmp/packages/pgadmin4 https://pgadmin-archive.postgresql.org/pgadmin4/yum/redhat/rhel-7Server-x86_64/pgadmin4-python3-mod_wsgi-4.9.0-1.el7.x86_64.rpm




chmod 755 -R /tmp

tar -cvzf  /var/www/html/packages.tar.gz /tmp/packages
rm -rf /tmp/packages
chown apache:apache /var/www/html/ -R

# Démarrer le serveur Apache en mode premier plan
echo "Démarrage de httpd..."
httpd -D FOREGROUND
