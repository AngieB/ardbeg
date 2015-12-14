FROM phusion/passenger-ruby22:latest
MAINTAINER Angie Brandt 'angiebrandt@gmail.com'

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

RUN apt-get update && apt-get install -y \
    bash \
    curl \
    libpq-dev \
    postgresql-client \
    vim

#Restart Nginx
RUN rm -f /etc/service/nginx/down

RUN rm -f /etc/nginx/sites-enabled/default
COPY ./testapp.conf /etc/nginx/sites-enabled/testapp.conf
COPY ./app-env.conf /etc/nginx/main.d/app-env.conf
COPY Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install

RUN mkdir -p /var/www/testapp
ADD . /var/www/testapp
RUN mkdir /var/www/testapp/shared
RUN chown -R app:app /var/www/testapp

WORKDIR /var/www/testapp

RUN sudo -u app bundle exec rake assets:precompile
