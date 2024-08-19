class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.string :full_name
      t.string :nickname
      t.string :email
      t.date :birthdate
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
