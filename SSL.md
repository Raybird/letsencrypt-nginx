1. start nginx
```
docker run --network host --rm \
-v $PWD/nginx/log:/var/log/nginx/ \
-v $PWD/nginx/nginx.conf:/etc/nginx/nginx.conf \
-v $PWD/nginx/conf/letsencrypt-nginx.conf:/etc/nginx/conf.d/default.conf \
-v $PWD/nginx/snippets:/etc/nginx/snippets \
-v $PWD/nginx/html:/usr/share/nginx/html \
-d nginx
```

```
docker run --rm -i -v $WEB_ROOT:/var/www -v $CERT_ROOT:/etc/letsencrypt -v $PWD/log:/var/log -w /var/www certbot/certbot --logs-dir /var/log certonly --agree-tos --webroot -w /var/www/temp -m "a691228@gmail.com" -d wmw.nctu.com
```

2. 申請證書,測試有增加 --dry-run

```
sudo certbot certonly --logs-dir $PWD/log --work-dir $PWD/work --webroot  --webroot-path $PWD/nginx/html/temp -d wmw.nctu.me -d www.wmw.nctu.me
```
```
IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/wmw.nctu.me/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/wmw.nctu.me/privkey.pem
   Your cert will expire on 2020-07-02. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot
   again. To non-interactively renew *all* of your certificates, run
   "certbot renew"
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le

```



```
docker run --rm \
-v $PWD/letsencrypt/etc:/etc/letsencrypt \
-v $PWD/letsencrypt/var:/var/lib/letsencrypt \
-v $PWD/letsencrypt/log:/var/log/letsencrypt \
-ti certbot/certbot \
certonly --manual \
--email a691228@gmail.com --agree-tos
```

```
docker run -i --rm \
-v $PWD/letsencrypt/etc:/etc/letsencrypt \
-v $PWD/letsencrypt/var:/var/lib/letsencrypt \
-v $PWD/letsencrypt/log:/var/log/letsencrypt \
-v $PWD/nginx/html:/data/letsencrypt \
certbot/certbot \
certonly --webroot \
--email a691228@gmail.com --agree-tos \
-w /data/letsencrypt \
--staging -d wmw.nctu.me -d www.wmw.nctu.me
```
```
docker run -it --rm \
-v $PWD/letsencrypt/etc:/etc/letsencrypt \
-v $PWD/letsencrypt/var:/var/lib/letsencrypt \
-v $PWD/letsencrypt/log:/var/log/letsencrypt \
-v $PWD/nginx/html:/data/letsencrypt \
certbot/certbot:v1.3.0 \
certonly --webroot \
--email a691228@gmail.com --agree-tos \
--webroot -w /data/letsencrypt \
--staging -d wmw.nctu.me
```

```
docker run --rm \
-v $PWD/letsencrypt/etc:/etc/letsencrypt \
-v $PWD/letsencrypt/var:/var/lib/letsencrypt \
-v $PWD/letsencrypt/log:/var/log/letsencrypt \
-p 80:80 -ti certbot/certbot \
certonly --standalone \
--email a691228@gmail.com --agree-tos \
--preferred-challenges http \
--staging -d wmw.nctu.me
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