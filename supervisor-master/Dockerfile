FROM vsense/baseimage:alpine

MAINTAINER vSense <docker@vsense.fr>

ENV BRANCH master

RUN apk add --update \
    git \
    python \
    unrar \
    zip \
    supervisor \
    && git clone -b $BRANCH --single-branch https://github.com/rembo10/headphones.git /headphones \
    && mkdir /config \
    && mkdir /downloads \
    && adduser -D -h /sickrage -s /sbin/nologin -u 5001 headphones \
    && chown -R headphones:headphones /headphones /config /downloads \
    && rm -rf /var/cache/apk/*

COPY supervisord-headphones.ini /etc/supervisor.d/supervisord-headphones.ini

VOLUME /config /downloads

EXPOSE 8181

CMD ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
