FROM lsiobase/alpine

LABEL maintainer "zaggash"

ENV NETDATA_VERSION=v1.5.0

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
  NETDATA_VERSION=$(echo "$NETDATA_VERSION" | sed 's/v//g') && \
  curl -sL https://github.com/firehol/netdata/releases/download/v$NETDATA_VERSION/netdata-$NETDATA_VERSION.tar.gz | tar xz -C /tmp -f - && \
  cd /tmp/netdata-$NETDATA_VERSION && \
  ./netdata-installer.sh --dont-wait --dont-start-it && \
  
  # cleanup
  cd ~ && \
  apk del --purge \
	build-dependencies && \
  rm -rf /var/cache/apk/* /tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 19999
VOLUME /config
