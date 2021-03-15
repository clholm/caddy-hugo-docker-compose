# adapted from jojomi/docker-hugo
FROM alpine:3.13.1@sha256:3747d4eb5e7f0825d54c8e80452f1e245e24bd715972c919d189a62da97af2ae

LABEL description="Docker container for building static sites with the Hugo static site generator."
LABEL maintainer="Connor Holm <connorlholm@gmail.com>"

# UID, GID args for /site dir
ARG UID=1000
ARG GID=1000

ENV HUGO_VERSION=0.80.0
ENV HUGO_BINARY hugo_extended_${HUGO_VERSION}_linux-64bit
ENV HUGO_DONWLOAD_LOCATION /usr/local/hugo/hugo-bin.tar.gz
ENV UID=$UID
ENV GID=$GID

USER root

# download and install hugo
RUN mkdir /usr/local/hugo
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}.tar.gz ${HUGO_DONWLOAD_LOCATION}
RUN tar xzf ${HUGO_DONWLOAD_LOCATION} -C /usr/local/hugo/ \
	&& ln -s /usr/local/hugo/hugo /usr/local/bin/hugo \
	&& rm ${HUGO_DONWLOAD_LOCATION}

# libc6-compat & libstdc++ are required for extended SASS libraries
# ca-certificates are required to fetch outside resources (like Twitter oEmbeds)
# entr is required for the run.sh script to watch for changes in src
RUN apk update \
    && apk add --upgrade --no-cache ca-certificates libc6-compat libstdc++ git entr rsync sudo

# copy watch script and set permissions
RUN mkdir /usr/local/site
COPY ./watch.sh /usr/local/site/watch.sh
RUN ln -s /usr/local/site/watch.sh /usr/local/bin/watch \
    && chmod 755 /usr/local/bin/watch

# copy build script and set permissions
COPY ./build.sh /usr/local/site/build.sh
RUN ln -s /usr/local/site/build.sh /usr/local/bin/build \
    && chmod 755 /usr/local/bin/build

# copy copy (lol) script and set permissions
COPY ./copy.sh /usr/local/site/copy.sh
RUN ln -s /usr/local/site/copy.sh /usr/local/bin/copy \
    && chmod 755 /usr/local/bin/copy

# set permissions on volumes
RUN addgroup -S worker-hugo && adduser -S worker-hugo -G worker-hugo
RUN mkdir /home/worker-hugo/site \
    && chown -R worker-hugo:worker-hugo /home/worker-hugo/site \
    && mkdir /home/worker-hugo/src \
    && chown -R worker-hugo:worker-hugo /home/worker-hugo/src \
    && mkdir /site \
    && chmod -R 775 /site

# set UID and GID env variables
RUN touch "/GID" && touch "/UID"
RUN echo "$GID" > "/GID" && echo "$UID" > "/UID"

# allow worker-hugo to use sudo with copy command
RUN echo "worker-hugo ALL = NOPASSWD: /usr/local/bin/copy " | tee -a /etc/sudoers

VOLUME /src
VOLUME /site

USER worker-hugo

WORKDIR /home/worker-hugo/src
CMD ["watch"]

# EXPOSE 1313
