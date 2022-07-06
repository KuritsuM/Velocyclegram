FROM ruby:2.7.5

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update -qq && apt-get install -qq --no-install-recommends \
    nodejs \
    ffmpeg \
    imagemagick \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN npm install -g yarn@1

ENV RAILS_ROOT /var/www/velocyclegram
RUN mkdir -p $RAILS_ROOT


RUN yarn install

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

EXPOSE 3000

RUN RAILS_ENV=production
RUN bundle exec rake assets:precompile

RUN rails webpacker:install

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]