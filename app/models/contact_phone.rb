class ContactPhone < ApplicationRecord
  # Associations
  belongs_to :contact

  # Validations
  validates :number, presence: true
  validates :emergency_number, presence: true
end
