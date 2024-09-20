```bash
docker build -t custom_centos78:latest .

docker run -it  -v "${pwd}/packages:/mnt/packages" custom_centos78
```
