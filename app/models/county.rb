class County < ApplicationRecord

  # Relationships
  has_many :items, through: :item_counties
  has_many :locations

  # Validations
  validates_presence_of :name

  # Scopes
  scope :alphabetical, -> { order('name') }
  scope :for_name, -> (name) { where('name=?',name) }

end
