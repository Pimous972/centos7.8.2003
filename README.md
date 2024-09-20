```bash
docker build -t custom_centos78:latest .

docker run -it  -v "${pwd}/packages:/tmp/packages" custom_centos78
```
