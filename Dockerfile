FROM ruby:2.7.0
LABEL maintainer "Embras mefti <mefti@embras.net>"

EXPOSE 3000
WORKDIR /app

ARG _USER=home/mefti

ENV TZ=Etc/UTC

RUN apt-get update -qq && \
	apt-get install -y libpq-dev nodejs build-essential locales tzdata && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    adduser mefti && mkdir /.gems && chown -R mefti:mefti /.gems


ENV LANG C.UTF-8

COPY ./.irbrc /${_USER}
COPY ./.pryrc /${_USER}
COPY ./.bashrc /${_USER}

# Reference: https://github.com/jfroom/docker-compose-rails-selenium-example
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
RUN chmod +x /docker-entrypoint.sh

# Add bundle entry point to handle bundle cache
ENV BUNDLE_PATH=/.gems \
    BUNDLE_BIN=/.gems/bin \
    GEM_HOME=/.gems
ENV PATH="${BUNDLE_BIN}:${PATH}"