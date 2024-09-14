class AddColumnsToContacts < ActiveRecord::Migration[7.1]
  def change
    add_column :contacts, :phone_number, :string
    add_column :contacts, :address, :string
  end
end
