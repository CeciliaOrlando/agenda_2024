require 'faker'

# Limpia los datos anteriores para evitar duplicados
ContactPhone.destroy_all
Contact.destroy_all
ContactAddress.destroy_all
User.destroy_all

# Crea un usuario
user = User.first || User.create!(
  email: 'cecilia@gmail.com',
  password: '12345678',
  password_confirmation: '12345678'
)

# Crear 20 contactos con direcciones y teléfonos
20.times do
  # Crear la dirección
  contact_address = ContactAddress.create!(
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,
    postal_code: Faker::Address.zip_code
  )

  # Crear el contacto
  contact = Contact.create!(
    user: user,
    full_name: Faker::Name.name,
    nickname: Faker::Name.first_name,
    email: Faker::Internet.email,
    contact_address: contact_address  # Asociar la dirección aquí
  )

  # Crear el teléfono
  contact_phone = ContactPhone.create!(
    number: Faker::PhoneNumber.phone_number,
    contact_id: contact.id  # Usar contact_id para asociar el teléfono al contacto
  )

  # Verifica que el contacto y el teléfono se hayan creado correctamente
  unless contact.persisted?
    puts "Failed to create contact: #{contact.errors.full_messages.join(", ")}"
  end

  unless contact_phone.persisted?
    puts "Failed to create contact phone for #{contact.full_name}: #{contact_phone.errors.full_messages.join(", ")}"
  end
end

puts "20 contacts have been created!"
