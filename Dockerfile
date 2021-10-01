FROM ruby:3.0.2
LABEL maintainer="dfreerksen@gmail.com"

ENV RAILS_ROOT /var/www/archangel
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

RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile.lock $RAILS_ROOT/
RUN bundle install --jobs 20 --retry 5

COPY package.json $RAILS_ROOT/
RUN yarn install --check-files

# The `node-sass` build is different for Mac and Windows and Linux
RUN npm rebuild node-sass

COPY . $RAILS_ROOT/

EXPOSE $PORT

COPY docker/app/entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["bin/rails", "server", "-b", "0.0.0.0"]
