require 'roda'
require 'fast_jsonapi'
require 'bcrypt'
require 'dry-validation'
require 'rack/unreloader'

require_relative 'db/database.rb'

dev = ENV['RACK_ENV'] == 'development'
Unreloader = Rack::Unreloader.new(subclasses: %w[Roda], reload: dev) { App }

Dir[File.join(__dir__, 'models', '*.rb')].sort.each { |file| require file }
Dir[File.join(__dir__, 'services/**/', '*.rb')].sort.each { |file| require file }
Dir[File.join(__dir__, 'contracts', '*.rb')].sort.each { |file| require file }

class App < Roda
  plugin :hash_routes

  ::Unreloader.require('routes') {}
  ::Unreloader.require('services/**/*.rb') {}
  ::Unreloader.require('routes/support/*.rb') {}

  route do |r|
    r.hash_routes('')
  end
end
