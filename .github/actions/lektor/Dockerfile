FROM python:3.10-alpine3.15

RUN set -eux ; \
    apk --no-cache upgrade ; \
    apk add --no-cache \
        imagemagick \
        make \
        git \
        openssh

COPY requirements.txt /app/requirements.txt
COPY Makefile /app/Makefile
COPY bin /app/bin
COPY lektor /app/lektor

#RUN set -eux ; \
#    pip install -r requirements.txt
RUN cd /app && make lektor-build

# For GitHub Actions to pass arguments to this container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

# might be a bad idea, but makes Lektor happy
ENV HOME=/tmp/lektor

EXPOSE 5000

# Do not set WORKDIR as it conflicts with GitHub Actions expectations

# you must map in the directory of a website to use this command
#CMD lektor server -h 0.0.0.0
CMD cd /app && make lektor-server
