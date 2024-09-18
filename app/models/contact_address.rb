class ContactAddress < ApplicationRecord

  # Método para generar la dirección completa
  def full_address
    "#{street}, #{city}, #{state}, #{postal_code}, #{country}"
  end

  # Configuración de geocoding
  geocoded_by :full_address
  after_validation :geocode, if: :will_save_change_to_street?

  # Associations
  has_many :contacts

  # Validations
  validates :street, :city, :state, :country, :postal_code, presence: true

  # Método para mostrar la dirección
  def to_s
    full_address
  end
end
