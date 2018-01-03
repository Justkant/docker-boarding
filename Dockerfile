FROM ruby:2.5.0
MAINTAINER Quentin Jaccarino <quentin@tracktl.com>

RUN apt-get update -qq && apt-get install -y build-essential \
    # for postgres
    libpq-dev \
    # for nokogiri
    libxml2-dev libxslt1-dev \
    # for capybara-webkit
    qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x \
    python python-dev python-pip python-virtualenv \
    nodejs \
    # cleanup
    && rm -rf /var/lib/apt/lists/*

WORKDIR /
RUN git clone https://github.com/fastlane/boarding.git \
 && cd boarding \
 && gem install bundler \
 && bundle install

WORKDIR /boarding
CMD bundle exec puma -C config/puma.rb