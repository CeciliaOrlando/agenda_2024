class Contact < ApplicationRecord
  # Método para buscar solo por nombre
  def self.search(query)
    if query.present?
      where('full_name ILIKE ?', "%#{query}%")
    else
      all
    end
  end

  # Associations
  belongs_to :user
  has_one :address, dependent: :destroy
  has_one :phone_number, dependent: :destroy
  has_one_attached :photo

  accepts_nested_attributes_for :address  #te permite manejar los atributos del modelo Address directamente a través del modelo User,

  # Validations
  validates :full_name, :email, :phone_number, :address, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
