#!/bin/sh

set -e

rm -f tmp/pids/sidekiq.pid

bundle exec sidekiq
