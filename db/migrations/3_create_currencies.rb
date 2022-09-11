Sequel.migration do
  up do
    create_table? :currencies do
      primary_key :id
      String :name
    end
  end

  down do
    drop_table? :currencies
  end
end
