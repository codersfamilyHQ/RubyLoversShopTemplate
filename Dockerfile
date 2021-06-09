ARG RUBY_VERSION=2.7.3
FROM ruby:${RUBY_VERSION}-slim

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle

ENV PATH="${BUNDLE_BIN}:${PATH}"

ARG APP_USER=appuser
ARG APP_GROUP=appgroup
ARG APP_USER_UID=1000
ARG APP_GROUP_GID=1000

RUN groupadd -f -g $APP_GROUP_GID -r $APP_GROUP && \
    useradd -u $APP_USER_UID --no-log-init -m -r -g $APP_GROUP $APP_USER

RUN apt-get update && \
    apt-get install -y curl wget gnupg2 && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      cmake \
      pkg-config \
      libpq-dev \
      nodejs \
      git \
      yarn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

## Add the wait script to the image
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.9.0/wait /wait
RUN chmod +x /wait

COPY docker-entrypoint.sh ./
RUN chmod +x ./docker-entrypoint.sh && \
    gem install bundler -v '~> 2.2'

RUN mkdir -p /app /bundle && \
    chown $APP_USER_UID:$APP_GROUP_GID -R /bundle

WORKDIR /app

ENTRYPOINT ["./docker-entrypoint.sh"]
