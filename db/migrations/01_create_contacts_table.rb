require 'sequel'

Sequel.migration do
  up do
    create_table(:contacts) do
      primary_key :id
      String :company
      String :firstname
      String :lastname
      String :straddress
      String :city
      String :stateprov
      String :country
      String :phone
      String :email
      String :notes, :text => true
      FalseClass :favorite
    end
  end

  down do
    drop_table(:contacts)
  end
end
