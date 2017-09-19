FROM ruby:2.4.1
RUN apt-get update -qq && apt-get install -y build-essential
RUN gem install bundler
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
RUN bundle install
ADD . /myapp
