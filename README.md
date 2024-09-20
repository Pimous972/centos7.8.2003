
# build de l'image
```bash
docker build -t custom_centos78:latest .
```


# lancement du conteneur
```bash
docker run -d   -p 8080:80 -v "${pwd}/packages:/tmp/" custom_centos78:latest
```

# téléchargement de l'archives

http://localhost/packages.tar.gz
