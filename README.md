# Archangel

[![CircleCI](https://circleci.com/gh/archangel/archangel/tree/master.svg?style=shield)](https://circleci.com/gh/archangel/archangel/tree/master)

Archangel is a headless CMS.

## Requirements

* Ruby 3.0.3 (see `.ruby-version`)
* Node >=16.14.0 (see `package.json`)
  * Install using NVM with `nvm install && nvm use`
    * Install NVM using Homebrew with `brew install nvm`
* Yarn >= 1.16.0 (see `package.json`)
  * Install using Homebrew with `brew install yarn`
* ImageMagick >= 6.x
  * Install using Homebrew with `brew install imagemagick`
* PostgreSQL >= 12.3
  * [Postgres.app](https://postgresapp.com/) (when running local tooling)
      * Install using Homebrew Cask with `brew install --cask postgres`
  * [Docker App](https://www.docker.com/products/docker-desktop) (when running with Docker)
      * Install using Homebrew Cask with `brew install --cask docker`

## Setup

Install or update application including dependencies

```
$ bin/setup
```

## Environment Variables

Create or recreate the environment variables file

```
$ cp -i .env.sample .env
```

You will need to edit the `.env` file accordingly

## Running

There are two ways to run the application; locally or with Docker

### Local

First, ensure [Postgres.app](https://postgresapp.com/) is running. Set up the database by running

```
$ bin/rails db:prepare
```

Start the server by running the following command in the console

```
$ bin/rails s
```

In your browser go to [http://localhost:3000](http://localhost:3000)

#### Sample Data

The database is empty by default. Seed the database with sample data

```
$ bin/rails db:seed
```

#### Migrations

Migrations can be run with the following command

```
$ bin/rails db:migrate RAILS_ENV=development
```

#### Redis

If Redis is needed (for background workers), either change the `JOB_QUEUE_ADAPTER` environment variable to `inline` to make it run in the same process or start a Redis server such as [Redis.app](https://github.com/jpadilla/redisapp) which can be installed with Homebrew Cask with `brew install --cask jpadilla-redis`

### Docker

First, make sure the domains used are in the `/etc/hosts` file

```
$ sudo sh -c "echo 127.0.0.1  www.archangel.local >> /etc/hosts"
$ sudo sh -c "echo 127.0.0.1  archangel.local >> /etc/hosts"
```

Next, ensure the [Docker](https://www.docker.com/products/docker-desktop) app is running. Set up the database by running

```
$ docker-compose build
$ docker-compose run app rails db:prepare
```

Start the server by running the following command in the console

```
$ docker-compose up
```

In your browser go to [http://archangel.local](http://archangel.local) or [http://localhost:3000](http://localhost:3000)

> NOTE: `binding.pry` does not work inside Docker without attaching the process. To use pry with Docker, a bin script has been created. To use pry with Docker, start the server by running `bin/dev`

#### Sample Data

The database is empty by default. Seed the database with sample data

```
$ docker-compose run app rails db:seed
```

#### Migrations

Migrations can be run with the following command

```
$ docker-compose run app rails db:migrate RAILS_ENV=development
```

## Testing

To run the entire test suite, run

```
$ bin/test
```

This will drop the test database, recreate it then run the [RSpec](https://github.com/rspec/rspec-rails) test suite.

It is not always necessary to drop and recreate the database as the schema does not often change. To run the test suite without dropping and recreating the database, you can simply run

```
$ bundle exec rspec spec
```

### CircleCI

[CircleCI](https://circleci.com/) is used to test the application.

To test the application as CircleCI would test it, first install the runner with

```
$ brew install circleci
```

Run tests as CircleCI

```
$ circleci local execute --job rspec
```

Validate the config file

```
$ circleci config validate
```

### Code Coverage

Code coverage is visualized with [Simplecov](https://github.com/colszowka/simplecov)

View coverage with

```
$ open coverage/index.html
```

## Documentation

[Yard](https://github.com/lsegal/yard) is used to generate documentation.

Build the documentation

```
$ yard doc
```

Build the documentation and list all undocumented objects

```
$ yard stats --list-undoc
```

## Swagger

Swagger API documentation

Test API integrations

```
$ bundle exec rspec spec/integration
```

Generate Swagger documentation

```
$ rake rswag:specs:swaggerize
```

In your browser go to [http://localhost:3000/swagger/index.html](http://localhost:3000/swagger/index.html) or [https://archangel.local/swagger/index.html](https://archangel.local/swagger/index.html)

> NOTE: When changes are made to the API and therefore any integrations in `spec/integration`, you will need to test the integrations and generate a new Swagger definition. A bin script has been created for this. Test integrations and build a Swagger definition by running `bin/swag`

### Validate

Swagger validate can be found at [https://editor.swagger.io/](https://editor.swagger.io/). Paste the contents of `swagger/v1/swagger.yml` into the validator to find any issues.

## Linting

Several tools are used to ensure code is styled, linted and formatted correctly.

### Brakeman

[Brakeman](https://github.com/presidentbeef/brakeman) is a static analysis security vulnerability scanner for Ruby.

```
$ bundle exec brakeman && open brakeman.html
```

### DatabaseConsistency

[DatabaseConsistency](https://github.com/djezzzl/database_consistency) is used to check the consistency of the database constraints with validations.

```
$ bundle exec database_consistency
```

### ESLint

[ESLint](https://github.com/eslint/eslint) is for Javascript linting. ESLint is installed with Yarn.

In general, it's best to run this linter within your IDE with available integrations such as [Atom](https://atom.io/packages/linter-eslint), [Sublime Text](https://github.com/SublimeLinter/SublimeLinter-eslint) or [VS Code](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint).

Manually run ESLint for the repo

```
$ yarn run eslint .
```

### i18n-tasks

[i18n-tasks](https://github.com/glebm/i18n-tasks) checks for missing and unused translations. i18n-tasks is installed with Bundler.

Translations are checked in tests. Only check for translation issues by running the tests with `bundle exec rspec spec/i18n_spec.rb` or running the entire test suite.

Manually run i18n-tasks

```
$ i18n-tasks health
```

### Rubocop

[Rubocop](https://github.com/rubocop-hq/rubocop) is for Ruby linting. Rubocop is installed with Bundler.

In general, it's best to run this linter within your IDE with available integrations such as [Atom](https://atom.io/packages/linter-rubocop), [Sublime Text](https://github.com/SublimeLinter/SublimeLinter-rubocop) or [VS Code](https://marketplace.visualstudio.com/items?itemName=misogi.ruby-rubocop).

Manually run Rubocop for the repo

```
$ rubocop
```

### Stylelint

[Stylelint](https://github.com/stylelint/stylelint) is for SASS, SCSS and CSS linting. Stylelint is installed with Yarn.

In general, it's best to run this linter within your IDE with available integrations such as [Atom](https://atom.io/packages/linter-stylelint), [Sublime Text](https://github.com/SublimeLinter/SublimeLinter-stylelint) or [VS Code](https://marketplace.visualstudio.com/items?itemName=thibaudcolas.stylelint).

Manually run Stylelint for the repo

```
$ yarn run stylelint "**/*.scss"
```
