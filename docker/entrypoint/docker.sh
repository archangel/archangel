#!/bin/sh

set -e

rm -f tmp/pids/server.pid

bin/rails server -b 0.0.0.0 -p 3000
