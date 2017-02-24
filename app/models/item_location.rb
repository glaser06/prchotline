class ItemLocation < ApplicationRecord

  belongs_to :item
  belongs_to :location



  scope :active, -> {where(active: true)}
  scope :by_days_since, -> {order('verified')}

  scope :for_item, -> (item){where("item_id=?",item)}
  scope :for_location, -> (loc){where("location_id=?",loc)}

end
