class Item < ApplicationRecord
  
  # Relationships
  has_many :counties, through: :item_counties
  has_many :locations, through: :item_locations

end
