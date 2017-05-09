class ItemCounty < ApplicationRecord

  belongs_to :item
  belongs_to :county

  validates_presence_of :item_id, :county_id

  scope :by_county, -> (county_id) { where("county_id = ?", county_id) }
  scope :by_item, -> (item_id) { where("item_id = ?", item_id) }

end
