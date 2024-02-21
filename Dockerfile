FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq && apt-get install -y \
    curl\
    gnupg\
    postgresql-client \
    awscli \
    snapd

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -E - \
    && apt-get install -y nodejs \
    && npm i -g heroku

COPY /scripts/fetch_and_restore.sh /run/script.sh
COPY version.txt version.txt
ENTRYPOINT ["/run/script.sh"]
