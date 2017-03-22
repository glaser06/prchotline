class Location < ApplicationRecord

  belongs_to :county, :foreign_key => "counties_id"
  has_many :item_locations
  has_many :items, through: :item_locations

  accepts_nested_attributes_for :item_locations, reject_if: lambda { |item_location| item_location[:item_id].blank? }, allow_destroy: true

  validates :name, :address, :city, :zipcode, :state, presence: true

  scope :alphabetical , -> { order('name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :for_zipcode, -> (zip) { where("zipcode=?", zip ) }
  scope :by_zipcode, -> { order('zipcode') }
  # scope :by_county, ->  { includes(:county).order('counties.name') }
  scope :for_county, -> (id) { where('counties_id=?', id) }

  def item_locations_for_form
    collection = item_locations.where(location_id: id)
    collection.any? ? collection : item_locations.build
  end

end
