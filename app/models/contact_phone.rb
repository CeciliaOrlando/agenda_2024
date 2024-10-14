class ContactPhone < ApplicationRecord
  # Associations
  #belongs_to :contact

  # Validations
  validates :contact_phone, presence: true, format: { with: /\A\d{10}\z/, message: "debe tener 10 dígitos" }
 end
