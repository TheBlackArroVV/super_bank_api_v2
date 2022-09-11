require_relative '../../app'

Sequel.migration do
  up do
    Currency.create(name: 'UAH')
    Currency.create(name: 'USD')
    Currency.create(name: 'EUR')
  end

  down do
    Currency.find(name: 'UAH')&.delete
    Currency.find(name: 'USD')&.delete
    Currency.find(name: 'EUR')&.delete
  end
end
