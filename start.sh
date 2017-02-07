#!/bin/sh
rails assets:precompile
rails db:create db:migrate
puma -C config/puma.rb
