class Contact < ApplicationRecord
  # Método para buscar solo por nombre
  def self.search(query)
    if query.present?
      where('full_name ILIKE ?', "%#{query}%")
    else
      all
    end
  end

  def formatted_contact_phone
    if contact_phone.is_a?(ContactPhone)
      contact_phone.number.gsub(/\D/, '').tap do |number|
        number.insert(0, '(').insert(4, ') ').insert(9, '-')
      end
    else
      contact_phone # Devuelve el número sin formatear si no es un objeto `PhoneNumber`
    end
  end

  def formatted_contact_address
    "#{contact_address.street}, #{contact_address.city}, #{contact_address.state} #{contact_address.postal_code}"
  end

  # Associations
  belongs_to :user
  has_one :contact_address
  belongs_to :contact_address,  dependent: :destroy
  has_one :contact_phone, dependent: :destroy
  #has_many_attached :photos

  accepts_nested_attributes_for :contact_address  #te permite manejar los atributos del modelo Address directamente a través del modelo User,

  # Validations
  validates :full_name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
