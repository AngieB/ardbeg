FROM ruby:2.2.3
MAINTAINER Angie Brandt 'angiebrandt@gmail.com'

## Create a user for the web app.
#RUN addgroup --gid 9999 app && \
#    adduser --uid 9999 --gid 9999 --disabled-password --gecos "Application" app && \
#    usermod -L app

RUN apt-get update && apt-get install -y \
    bash \
    build-esssential \
    git \
    libpq-dev \
    postgresql-client \
    vim

COPY Gemfile* /tmp
WORKDIR /tmp
RUN bundle install

RUN mkdir -p /var/www/testapp
ADD . /var/www/testapp
RUN mkdir /var/www/shared

CMD rails s -b 0.0.0.0
