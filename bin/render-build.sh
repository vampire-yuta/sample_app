#!/usr/bin/env bash
# exit on error
set -o errexit

rm -rf tmp/cache/

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:migrate:reset
#bundle exec rails db:migrate
bundle exec rails db:seed
