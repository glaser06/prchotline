class Location < ApplicationRecord

  has_many :item_locations
  has_many :items, through: :item_locations

  validates :name, :address, :city, :zipcode, :state, presence: true
  validates :phone, format: { with: /\d{3}-\d{3}-\d{4}/, message: "bad format" }

  scope :alphabetical , -> { order('name') }
  scope :active , -> { where(active: true) }
  scope :inactive , -> { where(active: false) }
  scope :search_zipcode, -> (zip) { where("zip=?", zip ) }

  scope :by_zipcode, -> { order('zipcode') }


end
