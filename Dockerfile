# Headphones Dockerfile

FROM gliderlabs/alpine

MAINTAINER Kevin Lefevre <klefevre@vsense.fr>

RUN apk-install \
    git \
    python \
    unrar \
    zip \
    supervisor \
    && git clone https://github.com/rembo10/headphones.git /headphones \
    && mkdir /config \
    && mkdir /downloads \
    && adduser -D -h /sickrage -s /sbin/nologin -u 5001 headphones \
    && chown -R headphones:headphones /headphones /config /downloads

COPY supervisord-headphones.ini /etc/supervisor.d/supervisord-headphones.ini

VOLUME /config /downloads

EXPOSE 8181

CMD ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
