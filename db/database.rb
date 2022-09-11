require 'sequel'
require 'singleton'
require 'dotenv/load'

class Database
  include Singleton

  attr_reader :db

  def initialize
    @db = Sequel.connect(database_url)
  end

  private

  def database_url
    return ENV['TEST_DATABASE_URL'] if ENV['RAKE_ENV'] == 'test'

    ENV['DATABASE_URL']
  end
end
