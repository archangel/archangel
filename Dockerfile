FROM ruby:3.0.2
LABEL maintainer="dfreerksen@gmail.com"

ENV APP_DIR /var/www/archangel
ENV PORT 3000

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
   echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -qq -y apt-utils \
                           build-essential \
                           imagemagick \
                           libpq-dev \
                           nodejs \
                           yarn
RUN apt-get clean

RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR

COPY Gemfile Gemfile.lock $APP_DIR/
RUN gem install bundler
RUN bundle install --jobs 20 --retry 5

COPY package.json $APP_DIR/
RUN yarn install --check-files

# The `node-sass` build is different for Mac and Windows and Linux
RUN npm rebuild node-sass

COPY . $APP_DIR/

EXPOSE $PORT
