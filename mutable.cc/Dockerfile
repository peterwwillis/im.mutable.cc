FROM python:3.10-alpine3.15

ARG LEKTOR_VERSION=3.3.4
ENV LEKTOR_VERSION=$LEKTOR_VERSION

RUN set -eux ; \
    apk --no-cache upgrade \
    ; apk add --no-cache imagemagick \
    ; pip install Lektor==${LEKTOR_VERSION}

# might be a bad idea, but makes Lektor happy
ENV HOME=/tmp/lektor

WORKDIR /app
VOLUME /app

EXPOSE 5000

# you must map in the directory of a website to use this command
CMD lektor server -h 0.0.0.0
