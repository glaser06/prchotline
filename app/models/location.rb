class Location < ApplicationRecord

  belongs_to :county, optional: true
  has_many :item_locations
  has_many :items, through: :item_locations

  # validates :name, :address, :city, :zipcode, :state, presence: true


  scope :alphabetical , -> { order('name') }

  scope :for_zipcode, -> (zip) { where("zipcode=?", zip ) }

  scope :by_zipcode, -> { order('zipcode') }

  scope :by_county, ->  { includes(:county).order('counties.name') }

  scope :for_county, -> (county) { where("name=?", county) }

end
