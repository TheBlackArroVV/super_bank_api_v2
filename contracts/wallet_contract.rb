class WalletContract < Dry::Validation::Contract
  params do
    required(:name).filled(:string)
    required(:amount).filled(:integer)
  end
end
