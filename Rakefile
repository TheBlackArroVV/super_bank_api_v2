namespace :db do
  require 'sequel/core'
  require 'dotenv/load'

  Sequel.extension :migration

  desc 'Run migrations'
  task :migrate, [:version] do |_t, args|
    version = args[:version]&.to_i
    Sequel.connect(ENV.fetch('DATABASE_URL')) do |db|
      Sequel::Migrator.run(db, 'db/migrations', target: version)
    end
  end

  desc 'Perform migration reset (full rollback and migration)'
  task :reset do
    Sequel.connect(ENV.fetch('DATABASE_URL')) do |db|
      Sequel::Migrator.run(db, 'db/migrations', target: 0)
      Sequel::Migrator.run(db, 'db/migrations')
    end
  end
end
