class User < Sequel::Model(Database.instance.db)
  include Attributes
  include BCrypt

  one_to_one :auth_token
  one_to_many :wallets

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
