class Contact < ApplicationRecord
  # Associations
  belongs_to :user
  has_one :address, dependent: :destroy
  has_one :phone_number, dependent: :destroy
  has_one_attached :photo

  accepts_nested_attributes_for :address  #te permite manejar los atributos del modelo Address directamente a través del modelo User,

  # Validations
  validates :full_name, :email, :nickname, presence: true

end

