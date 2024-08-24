class Address < ApplicationRecord
    # Associations
    belongs_to :contact

    # Validations
    validates :street, :city, :state, :country, :postal_code, presence: true
end


