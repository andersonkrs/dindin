# syntax = docker/dockerfile:1

# This Dockerfile is designed for production, not development. Use with Kamal or build'n'run by hand:
# docker build -t my-app .
# docker run -d -p 80:80 -p 443:443 --name my-app -e RAILS_MASTER_KEY=<value from config/master.key> my-app

# For a containerized dev environment, see Dev Containers: https://guides.rubyonrails.org/getting_started_with_devcontainer.html

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.3.3
FROM ruby:$RUBY_VERSION-alpine AS base

# Rails app lives here
WORKDIR /rails

# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

# Throw-away build stage to reduce size of final image
FROM base AS build

# Install glibc to correctly install Bun
RUN apk --no-cache add ca-certificates wget
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk
RUN apk add --no-cache --force-overwrite glibc-2.28-r0.apk

RUN apk add --update --no-cache \
  build-base \
  git \
  zip \
  tzdata \
  sqlite-dev \
  npm 

RUN npm install -g bun@1.1.12 --include=optional

# Verify bun installation
RUN bun --version

# Install node modules
COPY package.json bun.lockb ./
RUN cat package.json
RUN bun install --frozen-lockfile

# Install application gems
COPY .ruby-version Gemfile Gemfile.lock ./
RUN bundle install && bundle exec bootsnap precompile --gemfile

# Copy application code
COPY . .

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Final stage for app image
FROM base

ENV TMPDIR="/rails/tmp"

# Install dependencies:
# - tzdata: Timezones
# - libxml2 libxslt1 gcompat: Nokogiri
# - vips: ActiveStorage
# - zip Backups
RUN apk add --update --no-cache \
  bash curl \
  tzdata \
  sqlite-dev \
  redis \
  libxml2 libxslt gcompat \
  vips \
  zip

# Copy built artifacts: gems, application
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/rails", "server"]
