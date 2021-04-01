FROM ruby:2.6.6
LABEL maintainer "Luis Henrique <lhff.dev@gmail.com>"

EXPOSE 3000
WORKDIR /app

ARG _USER=home/lhffdev

ENV TZ=Etc/UTC

RUN apt-get update -qq && \
	apt-get install -y libpq-dev build-essential locales tzdata curl && echo $TZ > /etc/timezone && \
    adduser lhffdev && mkdir /.gems && chown -R lhffdev:lhffdev /.gems && \
    curl -fsSL https://deb.nodesource.com/setup_14.x | bash - && apt-get update -qq && apt-get install -y nodejs

ENV LANG C.UTF-8

COPY ./.irbrc /${_USER}
COPY ./.pryrc /${_USER}
COPY ./.bashrc /${_USER}

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
RUN chmod +x /docker-entrypoint.sh

ENV BUNDLE_PATH=/.gems \
    BUNDLE_BIN=/.gems/bin \
    GEM_HOME=/.gems
ENV PATH="${BUNDLE_BIN}:${PATH}"
