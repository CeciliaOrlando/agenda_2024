class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.references :contact, null: false, foreign_key: true
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
