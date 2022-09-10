Sequel.migration do
    change do
      create_table? :users do
        primary_key :id
        String :email
        String :name
        String :password
      end
    end
  end
  