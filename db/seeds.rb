require 'faker'

# Limpia los datos anteriores para evitar duplicados
ContactAddress.destroy_all
Contact.destroy_all
User.destroy_all

# Crea un usuario
user = User.first || User.create!(
  email: 'cecilia@gmail.com',
  password: '12345678',
  password_confirmation: '12345678'
)

# Crear 20 contactos con direcciones y teléfonos
20.times do
  contact_address = ContactAddress.create!(
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,
    postal_code: Faker::Address.zip_code
  )

  contact_phone = ContactPhone.create!(
    number: Faker::PhoneNumber.phone_number
  )

  Contact.create!(
    user: user,
    full_name: Faker::Name.name,
    nickname: Faker::Name.first_name,
    email: Faker::Internet.email,
    contact_phone: contact_phone,  # Asigna la instancia de ContactPhone
    contact_address: contact_address # Asigna la instancia de ContactAddress
  )
end

puts "20 contacts have been created!"
