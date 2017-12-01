# frozen_string_literal: true

ENV['TZ'] = 'Asia/Tokyo'

task :require do
  require 'rubygems'
  require 'bundler/setup'
  Bundler.require(:default)

  require_relative './lib/adventcalendar_ranking'
end

Dir['lib/tasks/**/*.rake'].each { |f| load f }

task default: 'adventcalendar_ranking:run'
