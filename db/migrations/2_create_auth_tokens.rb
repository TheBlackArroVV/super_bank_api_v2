Sequel.migration do
  up do
    create_table? :auth_tokens do
      primary_key :id
      String :token
      String :user_id
    end
  end

  down do
    drop_table? :auth_tokens
  end
end
