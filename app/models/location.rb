class Location < ApplicationRecord

  belongs_to :county, :foreign_key => "counties_id"
  has_many :item_locations
  has_many :items, through: :item_locations

  validates :name, :address, :city, :zipcode, :state, presence: true


  scope :alphabetical , -> { order('name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :for_zipcode, -> (zip) { where("zipcode=?", zip ) }
  scope :by_zipcode, -> { order('zipcode') }
  # scope :by_county, ->  { includes(:county).order('counties.name') }
  scope :for_county, -> (id) { where('counties_id=?', id) }


end
