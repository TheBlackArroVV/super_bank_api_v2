class Currency < Sequel::Model(Database.instance.db)
  include Attributes

  one_to_many :wallets
end
