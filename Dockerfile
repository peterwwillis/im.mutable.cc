# Build a container to do local Jekyll builds from.
# Replicate the version of ruby and jekyll that the prod server runs.

#FROM jekyll/jekyll:4
FROM ruby:2.7.4-alpine

ARG JEKYLL_VERSION=4.2.2
ENV JEKYLL_VERSION=${JEKYLL_VERSION}

ENV BUNDLE_HOME=/usr/local/bundle
ENV BUNDLE_APP_CONFIG=/usr/local/bundle
ENV BUNDLE_DISABLE_PLATFORM_WARNINGS=true
ENV BUNDLE_BIN=/usr/local/bundle/bin
ENV GEM_BIN=/usr/gem/bin
ENV GEM_HOME=/usr/gem
ENV RUBYOPT=-W0
ENV JEKYLL_VAR_DIR=/var/jekyll
ENV JEKYLL_DATA_DIR=/srv/jekyll
ENV JEKYLL_BIN=/usr/jekyll/bin
ENV JEKYLL_ENV=development
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV TZ=UTC
ENV PATH="$JEKYLL_BIN:$PATH"
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US
env VERBOSE=false
env FORCE_POLLING=false
env DRAFTS=false

#    && unset GEM_HOME \
#    && unset GEM_BIN \

RUN apk add --no-cache -t .build-deps \
        zlib-dev \
        libffi-dev \
        build-base \
        libxml2-dev \
        imagemagick-dev \
        readline-dev \
        libxslt-dev \
        libffi-dev \
        yaml-dev \
        zlib-dev \
        vips-dev \
        vips-tools \
        sqlite-dev \
        cmake \
    && apk add --no-cache \
        linux-headers \
        openjdk8-jre \
        less \
        zlib \
        libxml2 \
        readline \
        libxslt \
        libffi \
        git \
        nodejs \
        tzdata \
        shadow \
        bash \
        su-exec \
        npm \
        libressl \
        yarn \
    && echo "gem: --no-ri --no-rdoc" > ~/.gemrc \
    && yes | gem update --system \
    && gem install jekyll -v${JEKYLL_VERSION} -- --use-system-libraries \
    && gem install \
        html-proofer \
        jekyll-reload \
        jekyll-mentions \
        jekyll-coffeescript \
        jekyll-sass-converter \
        jekyll-commonmark \
        jekyll-paginate \
        jekyll-compose \
        jekyll-assets \
        RedCloth \
        kramdown \
        jemoji \
        jekyll-redirect-from \
        jekyll-sitemap \
        jekyll-feed \
        minima \
        -- \
        --use-system-libraries \
    && apk del .build-deps

WORKDIR /srv/jekyll

COPY Gemfile Gemfile.lock 404.html about.markdown index.markdown _config.yml _posts /srv/jekyll/

RUN bundle exec jekyll build -d ./public

VOLUME  /srv/jekyll

EXPOSE 35729
EXPOSE 4000
