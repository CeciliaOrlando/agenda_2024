class Category < ApplicationRecord
  # Associations
  belongs_to :contact
  has_many :contacts

  # Validations
  CATEGORIES = %w[Customer Supplier Family Friend].freeze
  validates :name, presence: true, inclusion: { in: CATEGORIES }
end
