$:.unshift File.expand_path('.') + '/lib'
require 'bundler/setup'
require 'config'
require 'client'
Tinker::Config.init
run Tinker::Client

