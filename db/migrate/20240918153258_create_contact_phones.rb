class CreateContactPhones < ActiveRecord::Migration[6.0]
  def change
    create_table :contact_phones do |t|
      t.string :number, null: false # Columna para el número de teléfono
      t.references :contact, null: false, foreign_key: true  # Relación con la tabla de contactos

      t.timestamps  # Agrega las columnas created_at y updated_at
    end
  end
end
