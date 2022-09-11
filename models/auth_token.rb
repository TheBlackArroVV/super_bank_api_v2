class AuthToken < Sequel::Model(Database.instance.db)
  include ::Attributes

  one_to_one :user
end
