class Item < ApplicationRecord

  # Relationships
  has_many :counties, through: :item_counties
  has_many :locations, through: :item_locations

  # Validations
  validates_presence_of :name

  # Scopes
  scope :alphabetical, -> { order('name') }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
  scope :for_name, -> (name) { where("name==?", name) }

  def search(item,county,zip)
    item = Item.find(item)
    locs = item.locations.active.for_zipcode(zip).alphabetical
    contexts = []
    locs.each do |loc|
      context = ItemLocation.active.for_item(item.id).for_location(loc.id)
      contexts.push(context)
    end
    return item,locs,contexts
  end



end
