class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

# database_authenticatable :ayuda a a verificar si el nombre de usuario  la contraseña de una persona son correctos
# registerable : ayuda a tu aplicación a registrar una nueva cuenta de usuario.
# recoverable : ayuda a tu aplicación a recuperar la contraseña de una cuenta de usuario.
# rememberable : ayuda a tu aplicación a recordar la contraseña de una cuenta de usuario.
# validatable : ayuda a tu aplicación a verifcar si los datos y la contraseña de una persona son correctos.

    # Associations
  has_many :contacts

    # Validations
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }
end
