class CreateContactAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :contact_addresses do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.integer :postal_code
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
