1. start nginx
```
docker run --network host --rm --name nginx-letsencrypt \
-v $PWD/nginx/conf/letsencrypt-nginx.conf:/etc/nginx/conf.d/default.conf \
-v $PWD/nginx/html:/usr/share/nginx/html \
-d nginx
```

2. 申請證書,測試有增加 --dry-run
```
docker run -it --rm \
-v $PWD/letsencrypt/etc:/etc/letsencrypt \
-v $PWD/letsencrypt/var:/var/lib/letsencrypt \
-v $PWD/letsencrypt/log:/var/log/letsencrypt \
-v $PWD/nginx/html:/data/letsencrypt \
certbot/certbot \
certonly --webroot \
--register-unsafely-without-email --agree-tos \
--webroot-path=/data/letsencrypt \
--dry-run \
-d wmw.nctu.me
```

3. start https
```
docker run --network host --rm --name nginx-https \
-v $PWD/nginx/conf/https-nginx.conf:/etc/nginx/conf.d/default.conf \
-v $PWD/letsencrypt/etc:/etc/letsencrypt \
-d nginx
```

4. renew
```
docker run --rm -it --name certbot \
-v $PWD/letsencrypt/etc:/etc/letsencrypt \
-v $PWD/letsencrypt/var:/var/lib/letsencrypt \
-v $PWD/letsencrypt/log:/var/log/letsencrypt \
-v $PWD/nginx/html:/data/letsencrypt \
certbot/certbot renew --webroot -w /data/letsencrypt
```