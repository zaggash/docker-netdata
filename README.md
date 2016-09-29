Based on linuxserver.io baseimage but NOT SUPPORTED by them.

# zaggash/docker-netdata
[![](https://images.microbadger.com/badges/image/zaggash/docker-netdata.svg)](https://microbadger.com/images/zaggash/docker-netdata "Get your own image badge on microbadger.com")
[hub]: https://hub.docker.com/r/zaggash/docker-netdata/

Real-time performance monitoring, done right! [Netdata](https://github.com/firehol/netdata/)

[![netdata](https://github.com/firehol/netdata/blob/master/web/images/seo-performance-256.png)][![netdata](https://github.com/firehol/netdata/blob/master/web/images/animated.gif)]

## Usage

```
docker create --name=netdata \
-v <path to data>:/config \
-e TZ \
-e PGID=<gid> -e PUID=<uid> \
-p 19999:19999 \
zaggash/docker-transmission
```

**Parameters**

* `-p 19999` - the port(s)
* `-v /config` - where transmission should store config files and logs
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` for timezone information

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it netdata /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

## Setting up the application 

Webui is on port 19999


## Info

* To monitor the logs of the container in realtime `docker logs -f netdata`.
