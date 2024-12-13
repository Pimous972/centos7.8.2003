# Installation et Configuration des Dépôts et Packages  Centos 7.8

Ce script est conçu pour être exécuté dans un conteneur Docker. Il installe plusieurs dépôts et paquets nécessaires à l'exécution de PHP, PostgreSQL, GitLab Runner, et MariaDB, puis télécharge les dépendances associées pour ces technologies. Le script crée aussi un fichier `tar` contenant ces paquets pour faciliter leur distribution ou installation ultérieure.

## Prérequis

- Un conteneur Linux fonctionnel (voir le fichier DockerFile)
- Modification du script startup-script.sh pour ajouter les paquets souhaités
- Un accès à Internet pour télécharger les paquets.

## Fonctionnalités

1. **Installation des dépôts** :
   - Remi pour PHP
   - PostgreSQL
   - GitLab Runner
2. **Téléchargement des dépendances** :
   - Paquets PHP pour plusieurs versions (7.4, 8.2, 8.3).
   - Dépendances pour plusieurs versions de PostgreSQL et MariaDB.
   - Téléchargement de l'installateur de `gitlab-runner`.
   - Téléchargement des paquets `pgAdmin4`.
3. **Compression des paquets téléchargés** :
   - Tous les paquets téléchargés sont compressés dans un fichier `tar` dans `/var/www/html`.
4. **Configuration d'Apache** :
   - Le serveur Apache (`httpd`) est démarré en mode premier plan pour permettre la gestion du conteneur.

## Installation et Utilisation

1. **Clôner le repo** :
```bash
git clone https://github.com/Pimous972/centos7.8.2003.git
```

2. **Modifiction du scrip startup-script.sh** :

Editez le scrip `startup-script.sh` si vous souhaitez faire ajouter un paquet

3. **Build de l'image** :

Placez vous dans le répertoire et buildez l'image
```bash
cd centos7.8.2003
docker build -t custom_centos78:latest .
```

3. **Lancement du conteneur** :
```bash
# avec podman
docker run -p 80:80 custom_centos78:latest

# avec podman
podman run -p 80:80  localhost/custom_centos78:latest
```
# volumes:
    #   - ./packages:/mnt/packages  # Monte le répertoire local "packages" dans "/mnt/packages" du conteneur

3. **Téléchargement de l'archive** :
```bash
http://<IP DU SERVEUR>/packages.tar.gz
```

## Détails du Processus

### 1. Installation des dépôts
Installation des dépôts suivants :
- **Remi** : Pour installer plusieurs versions de PHP.
- **PostgreSQL** : Pour installer PostgreSQL et ses dépendances.
- **GitLab Runner** : Pour ajouter le dépôt GitLab Runner et installer la dernière version.
- **Nettoyage et mise en cache de `yum`**.

### 2. Téléchargement des dépendances
Télechargement des dépendances suivantes pour chaque technologie :
- **PHP (versions 7.4, 8.2, 8.3)** : Plusieurs paquets nécessaires au bon fonctionnement de PHP, y compris les modules pour PostgreSQL, MySQL, GD, et autres.
- **PostgreSQL (versions 9 à 15)** : Paquets pour PostgreSQL, y compris les bibliothèques, le serveur, et les outils associés.
- **MariaDB (versions 10.1 à 10.5)** : Paquets pour MariaDB.
- **GitLab Runner** : La dernière version stable de GitLab Runner.
- **pgAdmin4** : Paquets nécessaires pour installer et configurer `pgAdmin4`.

### 3. Compression des fichiers
Tous les paquets téléchargés sont compressés dans un fichier `packages.tar.gz` situé dans `/var/www/html`. Ce fichier peut être utilisé pour d'autres installations ou partages.

### 4. Lancement d'Apache
Le serveur web Apache est démarré en mode premier plan (`httpd -D FOREGROUND`), ce qui signifie que le processus Apache restera en avant-plan dans le conteneur.
