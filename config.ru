$:.unshift File.expand_path('.') + '/lib'
require 'bundler/setup'
require 'client'
run Tinker::Client

