require 'roda'
require 'fast_jsonapi'
require_relative 'db/database.rb'
Dir[File.join(__dir__, 'models', '*.rb')].sort.each { |file| require file }

class App < Roda
  plugin :hash_routes

  # Unreloader.require('routes') {}

  route do |r|
    r.hash_routes('')
  end
end
