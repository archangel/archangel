FROM --platform=linux/amd64 ruby:3.0.3
LABEL maintainer="David Freerksen <dfreerksen@gmail.com>"

ARG RAILS_ENV=development
ARG NODE_ENV=development
ARG BUNDLE_VERSION=2.3.6

ENV NODE_ENV="${NODE_ENV}"
ENV RAILS_ENV="${RAILS_ENV}"

ENV RAILS_ROOT /var/www/archangel
ENV PORT 3000

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
   echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -qq -y --no-install-recommends build-essential \
                                                   apt-utils \
                                                   curl \
                                                   imagemagick \
                                                   libpq-dev \
                                                   nodejs \
                                                   yarn
RUN apt-get clean

RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile.lock $RAILS_ROOT/
RUN gem install bundler -v ${BUNDLE_VERSION} && bundle install --jobs 20 --retry 5

COPY package.json $RAILS_ROOT/
RUN yarn install --check-files

# The `node-sass` build is different for Mac and Windows and Linux
RUN npm rebuild node-sass

COPY . $RAILS_ROOT/

RUN if [ "${RAILS_ENV}" != "development" ]; then \
    bin/rails assets:precompile; fi

EXPOSE $PORT

COPY docker/app/entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["bin/rails", "server", "-b", "0.0.0.0"]
