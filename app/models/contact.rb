class Contact < ApplicationRecord
  # Método para buscar solo por nombre
  def self.search(query)
    if query.present?
      where('full_name ILIKE ?', "%#{query}%")
    else
      all
    end
  end

  def formatted_phone_number
    if phone_number.is_a?(PhoneNumber)
      phone_number.number.gsub(/\D/, '').tap do |number|
        number.insert(0, '(').insert(4, ') ').insert(9, '-')
      end
    else
      phone_number # Devuelve el número sin formatear si no es un objeto `PhoneNumber`
    end
  end

  def formatted_address
    "#{address.street}, #{address.city}, #{address.state} #{address.postal_code}"
  end

  # Associations
  belongs_to :user
   has_one :address, dependent: :destroy
  has_one :phone_number, dependent: :destroy
  #has_many_attached :photos

  accepts_nested_attributes_for :address  #te permite manejar los atributos del modelo Address directamente a través del modelo User,

  # Validations
  validates :full_name, :email, :phone_number, :address, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
