class Address < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  
    # Associations
    belongs_to :contact

    # Validations
    validates :street, :city, :state, :country, :postal_code, presence: true
end
