class AddContactIdToContactAddresses < ActiveRecord::Migration[7.1]
  def change
    add_reference :contact_addresses, :contact, foreign_key: true
  end
end
