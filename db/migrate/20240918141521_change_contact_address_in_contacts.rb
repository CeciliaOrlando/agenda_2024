class ChangeContactAddressInContacts < ActiveRecord::Migration[7.1]
  def change
    remove_column :contacts, :contact_address, :string # Eliminar el campo existente
    add_reference :contacts, :contact_address, foreign_key: true # Agregar la referencia a contact_addresses
  end
end
