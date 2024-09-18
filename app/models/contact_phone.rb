class ContactPhone < ApplicationRecord
  # Associations
  #belongs_to :contact

  # Validations
  validates :number, presence: true
 end
