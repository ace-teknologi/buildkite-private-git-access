FROM ruby:2.7.2-slim-buster as builder

ARG SSH_KEY

RUN apt-get update && apt-get install -y build-essential git openssh-client

# Needed for private GIT repository access
RUN mkdir -p /root/.ssh && \
    echo "$SSH_KEY" > /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa && \
    ssh-keyscan github.com > /root/.ssh/known_hosts

# Check that we can connect to github
RUN ssh -T git@github.com; LOGIN=$?; \
    if [ "$LOGIN" = "255" ] ; \
    then echo "----" && echo "SSH KEY ERROR (CODE: $LOGIN): YOU NEED TO USE BUILD ARGS! README.md FOR MORE INFO" && echo "----" && exit 1; \
    else exit 0; \
    fi

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

WORKDIR /app

RUN \
  gem install bundler && \
  bundle update --bundler && \
  bundle install && \
  chown -R root:root /usr/local/bundle

FROM ruby:2.7.2-slim-buster

LABEL maintainer="Joel Courtney <joel@ace-teknlogi[dot]com>"
LABEL application="Buildkite - Private git access example"

RUN apt-get update && apt-get install -y build-essential git openssh-client zip

# This step only copies the gems we care about from the builder container;
# that way our ssh creds do not propogate through the end use container.
COPY --from=builder /usr/local/bundle /usr/local/bundle

COPY . /app

WORKDIR /app
