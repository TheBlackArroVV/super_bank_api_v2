class Currency < Sequel::Model(Database.instance.db)
  include Attributes
end
