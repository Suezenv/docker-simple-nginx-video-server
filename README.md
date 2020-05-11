Simple nginx video server
=========================

This docker is able to server videos from /var/www/videos with secure link

# Build

build it as normal

```
  docker build -t suezenv/simple-nginx-video-server:<version> . && docker push suezenv/simple-nginx-video-server:<version> 
  docker tag  suezenv/simple-nginx-video-server:<version> suezenv/simple-nginx-video-server:latest && docker push suezenv/simple-nginx-video-server:latest
```

# Dev 

You can use docker-compose to test Dockerfile and script

```
  docker-compose up --build
```

# Use

```
  docker run --name my-server -v /www-root:/var/www:ro -d simple-nginx-video-server --env URI_SECRETS=my_secrets
```

To generate secrets, you can simple use this command `date +%s | sha256sum | base64 | head -c 32 ; echo`


like this : https://www.nginx.com/blog/securing-urls-secure-link-module-nginx-plus/

To generate link you can use  : 

generate <expire-date> as timestamp :

```
  # date -d "2020-12-31 23:59" +%s
  1609455540
```

generate <token> (don't forgot to add the <client IP>), <URI_secrets> is the secrets configured for this docker :

```
  # echo -n '<date>/videos/<path>/<video_file><client IP> <URI_secrets>' | openssl md5 -binary | openssl base64 | tr +/ -_ | tr -d =
  V8kqPRU8d-QeKrNhPnJrvA
``` 

An now you can call url like this :

```
  http://<host>/videos/<path>/<video_file>?md5=<token>&expires=<expire-date>
```