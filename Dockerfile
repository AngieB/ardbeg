FROM ruby:2.2.3
MAINTAINER Angie Brandt 'angiebrandt@gmail.com'

## Create a user for the web app.
#RUN addgroup --gid 9999 app && \
#    adduser --uid 9999 --gid 9999 --disabled-password --gecos "Application" app && \
#    usermod -L app

RUN apt-get update && apt-get install -y \
    bash \
    curl \
    build-essential \
    git \
    libpq-dev \
    postgresql-client \
    vim

RUN curl -sL https://deb.nodesource.com/setup_5.x | bash - && \
    apt-get install -y nodejs

COPY Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install

RUN mkdir -p /var/www/testapp
ADD . /var/www/testapp
RUN mkdir /var/www/shared

WORKDIR /var/www/testapp
VOLUME /var/www/testapp/shared

RUN bundle exec rake assets:precompile
RUN bundle exec rake db:migrate

CMD rails s -b 0.0.0.0
