FROM nextcloud:33-apache

RUN apt-get update && apt-get install -y \
    supervisor \
    ffmpeg \
    libmagickwand-dev \
    ghostscript \
    cron \
    libsmbclient-dev \
    libgmp-dev \
    curl \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /var/log/supervisord /var/run/supervisord

RUN docker-php-ext-install gmp

COPY supervisord.conf /

ENV NEXTCLOUD_UPDATE=1

CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]