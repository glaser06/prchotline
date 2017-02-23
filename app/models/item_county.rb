class ItemCounty < ApplicationRecord

  # Relationships
  belongs_to :item
  belongs_to :county
end
