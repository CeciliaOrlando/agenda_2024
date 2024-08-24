# db/migrate/xxxx_change_number_to_string_in_phone_numbers.rb
class ChangeNumberToStringInPhoneNumbers < ActiveRecord::Migration[7.1]
  def change
    # Cambia la columna 'number' en la tabla 'phone_numbers' de tipo 'integer' a tipo 'string'
    change_column :phone_numbers, :number, :string
  end
end
