#!/bin/sh
rails assets:precompile
rails db:migrate
puma -C config/puma.rb
