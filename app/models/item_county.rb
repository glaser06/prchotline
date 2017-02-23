class ItemCounty < ApplicationRecord

  # Relationships
  belongs_to :item
  belongs_to :county

  # Validations
  validates_presence_of :item_id, :county_id

  # Scopes
  scope :by_county, -> (county_id) { where("county_id = ?", county_id) }

end
