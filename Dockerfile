FROM arm32v7/debian:stretch-slim

LABEL maintainer="Giovanbattista Amato <giovanbattista.amato@outlook.com>"

RUN apt-get update && \
    apt-get install -yq varnish && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY default.vcl /etc/varnish/default.vcl

ADD start.sh /start.sh

ENV VCL_CONFIG /etc/varnish/default.vcl
ENV CACHE_SIZE 64m
ENV VARNISHD_PARAMS -p default_ttl=3600 -p default_grace=3600

CMD ["bash", "/start.sh"]

EXPOSE 80