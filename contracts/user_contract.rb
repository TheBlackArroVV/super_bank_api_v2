class UserContract < Dry::Validation::Contract
  params do
    required(:email).filled(:string)
    required(:password).filled(:string)
    required(:password_confirmation).filled(:string)
  end

  rule(:password, :password_confirmation) do
    key.failure('Passwords are not the same') unless values[:password] == values[:password_confirmation]
  end

  rule(:email) do
    key.failure('Email already in use') unless User.find(email: value).nil?
  end
end
