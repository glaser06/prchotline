class ItemLocation < ApplicationRecord

  # Relationships
  belongs_to :item
  belongs_to :location, required: false

  # Scopes

  scope :active, -> {where(active: true)}
  scope :by_days_since, -> {order('verified')}
  scope :for_item, -> (item){where("item_id=?",item)}
  scope :for_location, -> (loc){where("location_id=?",loc)}
  scope :by_item, -> { joins(:item, :item).order('items.name') }

end
