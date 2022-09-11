class Wallet < Sequel::Model(Database.instance.db)
  include Attributes

  many_to_one :currency
  many_to_one :user
end
