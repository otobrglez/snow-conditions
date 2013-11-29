require 'bundler/setup'
require 'webmock/rspec'
require 'dotenv'

ENV["COND_ENV"]||="test"

Dotenv.load

require "snow"
