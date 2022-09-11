require 'roda'
require 'fast_jsonapi'
require 'bcrypt'
require 'dry-validation'

require_relative 'db/database.rb'

Dir[File.join(__dir__, 'models', '*.rb')].sort.each { |file| require file }
Dir[File.join(__dir__, 'services/**/', '*.rb')].sort.each { |file| require file }
Dir[File.join(__dir__, 'contracts', '*.rb')].sort.each { |file| require file }

class App < Roda
  plugin :hash_routes

  Unreloader.require('routes') {}
  Unreloader.require('services/**/*.rb') {}
  Unreloader.require('routes/support/*.rb') {}

  route do |r|
    r.hash_routes('')
  end
end
