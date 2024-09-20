FROM centos:centos7.8.2003

# Définir le mainteneur
LABEL maintainer="pimoos972@gmail.com"

# Copier et personnaliser le fichier CentOS-Base.repo
COPY CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
COPY MariaDB.repo /etc/yum.repos.d/MariaDB.repo
# Ajouter un dépôt personnel (ex. custom.repo)
# COPY custom.repo /etc/yum.repos.d/custom.repo


# Mettre à jour le système et installer les outils nécessaires
RUN yum clean all && yum makecache && yum -y install vim wget curl



# Ajouter le script à exécuter au démarrage
COPY startup-script.sh /usr/local/bin/startup-script.sh
RUN chmod +x /usr/local/bin/startup-script.sh

WORKDIR /home

# Exécuter le script lors du démarrage du conteneur
CMD ["/usr/local/bin/startup-script.sh"]

