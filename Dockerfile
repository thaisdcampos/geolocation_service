FROM ruby:2.7.0

ENV INSTALL_PATH /opt/geo_app

RUN apt-get update -qq
RUN apt-get install -y build-essential libpq-dev

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler
RUN bundle install

COPY . $INSTALL_PATH
