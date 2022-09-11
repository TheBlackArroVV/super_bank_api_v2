Sequel.migration do
  up do
    create_table? :wallets do
      primary_key :id
      String :name
      BigDecimal :amount
      Integer :currency_id
      Integer :user_id
    end
  end

  down do
    drop_table? :wallets
  end
end
