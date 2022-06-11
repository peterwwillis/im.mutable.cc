FROM python:3.10-alpine3.15

ARG LEKTOR_VERSION=3.3.4
ENV LEKTOR_VERSION=$LEKTOR_VERSION

RUN set -eux ; \
    apk --no-cache upgrade \
    ; apk add --no-cache imagemagick \
    ; pip install Lektor==${LEKTOR_VERSION}

WORKDIR /app

VOLUME /app

CMD lektor server
