class County < ApplicationRecord

  # Relationships
  has_many :items, through: :item_counties

  # Validations
  validates_presence_of :name

  # Scopes
  scope :alphabetical, -> { order('name') }
  
end
