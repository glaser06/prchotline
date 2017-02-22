class Item < ApplicationRecord
  
  # Relationships
  has_many :item_locations
  has_many :item_counties

end
