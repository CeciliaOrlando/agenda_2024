class CreatePhoneNumbers < ActiveRecord::Migration[7.1]
  def change
    create_table :phone_numbers do |t|
      t.integer :number
      t.integer :emergency_number
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
