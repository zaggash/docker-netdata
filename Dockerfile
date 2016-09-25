FROM lsiobase/alpine
MAINTAINER zaggash

# copy local files
COPY root/ /

RUN \
  apk add --no-cache --virtual=build-dependencies \
    autoconf \
    automake \
    build-base \
    bash \
    curl \
    libmnl-dev \
    zlib-dev \
    util-linux-dev && \

  apk add --no-cache \
    python \
    ssmtp \
    docker \
    jq \
    libmnl \
    libuuid  && \
  
  # Compile
  NETDATA_VERSION=$(curl -sX GET  "https://api.github.com/repos/firehol/netdata/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]' | sed 's/v//') && \
  curl -sL https://github.com/firehol/netdata/releases/download/v$NETDATA_VERSION/netdata-$NETDATA_VERSION.tar.gz | tar xz -C /tmp -f - && \
  cd /tmp/netdata-$NETDATA_VERSION && \
  ./netdata-installer.sh --dont-wait --dont-start-it && \
  
  # cleanup
  cd ~ && \
  userdel netdata && groupdel netdata && \
  rm -f /etc/ssmtp.conf && cp /defaults/ssmtp.conf /etc/ssmtp.conf && \
  apk del --purge \
	build-dependencies && \
  rm -rf /var/cache/apk/* /tmp/*

# ports and volumes
EXPOSE 19999
VOLUME /config
