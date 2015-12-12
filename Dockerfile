FROM ruby:2.2.3
MAINTAINED BY Angie Brandt 'angiebrandt@gmail.com'

HOME /root

## Create a user for the web app.
RUN addgroup --gid 9999 app && \
    adduser --uid 9999 --gid 9999 --disabled-password --gecos "Application" app && \
    usermod -L app

RUN apt-get update && apt-get install \
    build-esssential \
    git \
    postgresql-client \
    vim

ADD
    
