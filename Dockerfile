FROM ruby:2.7.0

LABEL author.name="SonPham" \
author.email="pham.ngoc.son@sun-asterisk.com"

RUN apt-get update -qq && \
  apt-get install -y nodejs

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]