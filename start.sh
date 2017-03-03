#!/bin/sh
rails assets:precompile
rails db:migrate
bin/delayed_job start
puma -C config/puma.rb
