#!/usr/bin/env bash
# exit on error
set -o errexit

# bundle install
bundle install --with development test
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:purge
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed