class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.references :contact, null: false, foreign_key: true
      t.string :customer
      t.string :supplier
      t.string :family
      t.string :friend

      t.timestamps
    end
  end
end
