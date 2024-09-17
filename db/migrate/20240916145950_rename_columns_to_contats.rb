class RenameColumnsToContats < ActiveRecord::Migration[7.1]
  def change
    rename_column :contacts, :address, :contact_address
    rename_column :contacts, :phone_number, :contact_phone
  end
end
