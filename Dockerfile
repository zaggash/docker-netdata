FROM lsiobase/alpine

LABEL maintainer "zaggash"

ENV NETDATA_VERSION=v1.8.0

RUN \
  apk add --no-cache \
    python \
    ssmtp \
    docker \
    jq \
    libmnl \
    libuuid \
    python \
    curl \
    netcat-openbsd \
    lm_sensors \
    nodejs \
    py-mysqldb \
    py-psycopg2 \
    py-yaml && \
  
  # Compile
  curl https://my-netdata.io/kickstart-static64.sh >/tmp/kickstart-static64.sh
  sh /tmp/kickstart-static64.sh --dont-wait && \
  
  # cleanup
  cd ~ && \
  apk del --purge \
	build-dependencies && \
  rm -rf /var/cache/apk/* /tmp/* /etc/init.d

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 19999
VOLUME /config
