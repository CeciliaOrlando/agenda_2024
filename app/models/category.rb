class Category < ApplicationRecord
  # Associations
  belongs_to :contact
  CATEGORIES = %w[customer supplier family friend]

  # Validations
  validates :name, presence: true, inclusion: { in: CATEGORIES }
end
