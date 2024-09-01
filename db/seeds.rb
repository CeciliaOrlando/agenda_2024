require 'faker'

# Limpia los datos anteriores para evitar duplicados
PhoneNumber.destroy_all
Address.destroy_all
Contact.destroy_all
User.destroy_all

# Crea un usuario
user = User.first || User.create!(
  email: 'cecilia@gmail.com',
  password: '12345678', # Devise requiere una contraseña con un mínimo de 8 caracteres por defecto
  password_confirmation: '12345678'
)

# Crea contactos
20.times do
  contact = Contact.create!(
    user: user,
    full_name: Faker::Name.name,
    nickname: Faker::Name.first_name, # Usa `first_name` para apodos
    email: Faker::Internet.email
  )

  # Crea direcciones para cada contacto
  Address.create!(
    contact: contact,
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,
    postal_code: Faker::Address.zip_code,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude
  )

  # Crea números de teléfono para cada contacto
  PhoneNumber.create!(
    contact: contact,
    number: Faker::PhoneNumber.phone_number,
    emergency_number: '911' # Puedes ajustar esto según tus necesidades
  )
end

puts "20 contacts have been created!"
