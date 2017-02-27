class Item < ApplicationRecord

  # Relationships
  has_many :item_locations
  has_many :item_counties
  has_many :counties, through: :item_counties
  has_many :locations, through: :item_locations

  # Validations
  validates_presence_of :name

  # Scopes
  scope :alphabetical, -> { order('name') }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
  scope :for_name, -> (name) { where("name==?", name) }

  def self.search(item1,county,zip)
    item = Item.for_name(item1)
    print "-------", item.count, "\n"
    if item.blank?
      return [],[],[]
    end
    locs = item[0].locations.for_zipcode(zip).alphabetical
    contexts = []
    locs.each do |loc|
      context = ItemLocation.active.for_item(item[0].id).for_location(loc.id)
      contexts.push(context)
    end
    return item,locs,contexts
  end



end
