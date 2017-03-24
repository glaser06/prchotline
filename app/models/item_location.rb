class ItemLocation < ApplicationRecord

  belongs_to :item
  belongs_to :location, required: false

  # validates_uniqueness_of :item_id, scope: [:location_id]

  scope :active, -> {where(active: true)}
  scope :by_days_since, -> {order('verified')}

  scope :for_item, -> (item){where("item_id=?",item)}
  scope :for_location, -> (loc){where("location_id=?",loc)}

  scope :by_item, -> { joins(:item, :item).order('items.name') }


  #scope :alphabeticalByItem, -> (item){joins(:item).where("item_id=?").order("item.name")}
  # scope :for_owner, ->(owner_id) { where("owner_id = ?", owner_id) }
  # scope :alphabetical, -> { order('name') }
  # scope :search, ->(term) { joins(:animal).where('pets.name LIKE ?', "#{term}%").order("pets.name") }

end
