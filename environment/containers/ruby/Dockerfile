FROM ruby:2.7.6-alpine3.16 as base_image
RUN apk add --no-cache git \
    build-base \
    libpq-dev \
    tzdata

FROM base_image as development
COPY ./artifacts/rails/Gemfile /tmp/Gemfile
COPY ./artifacts/rails/Gemfile.lock /tmp/Gemfile.lock
COPY ./containers/ruby/runners/runner.development.sh /rdebug_ide/runner.sh
RUN cd /tmp && \
  gem install ruby-debug-ide && \
  gem install debase && \
  bundle install && \
  chmod +x /rdebug_ide/runner.sh && \
  apk add --no-cache git \
  nodejs \
  yarn
WORKDIR /app

ENTRYPOINT ["tail", "-f", "/dev/null"]

FROM base_image as init
COPY ./containers/ruby/initializers/runner.init.sh /tmp/runner.sh
COPY ./containers/ruby/initializers/database.yml /tmp/database.yml
COPY ./containers/ruby/initializers/.gitignore /tmp/.gitignore
COPY ./containers/ruby/initializers/development.rb /tmp/development.rb
RUN chmod +x /tmp/runner.sh

WORKDIR /app

ENTRYPOINT ["/tmp/runner.sh"]
