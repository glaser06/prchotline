class Item < ApplicationRecord

  has_many :item_locations, dependent: :destroy
  has_many :item_counties, dependent: :destroy
  has_many :counties, through: :item_counties
  has_many :locations, through: :item_locations
  has_many :addresses, through: :locations
  has_many :aliases, dependent: :destroy

  validates_presence_of :name

  accepts_nested_attributes_for :aliases, reject_if: lambda { |attraction| attraction[:name].blank? }, allow_destroy: true

  scope :alphabetical, -> { order('name') }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
  scope :for_name, -> (name) { where("name=?", name) }

end
