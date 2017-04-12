class Location < ApplicationRecord

  before_save :reformat_phone

  has_many :item_locations
  has_many :items, through: :item_locations
  has_many :addresses, :autosave => true

  accepts_nested_attributes_for :item_locations, reject_if: lambda { |item_location| item_location[:item_id].blank? }, allow_destroy: true
  accepts_nested_attributes_for :addresses, reject_if: lambda { |addr| addr[:address].blank? }, allow_destroy: true

  validates :name, presence: true
  validates_format_of :phone, with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "should be 10 digits (area code needed) and delimited with dashes only", allow_blank: true
  #TO DO validates format of website

  validate :require_one_address

  scope :alphabetical , -> { order('name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :for_county, -> (id) {Location.joins(:addresses).where(addresses: {county_id: id})}

  scope :for_item, -> (id) {Location.joins(:item_locations).where(item_locations: {item_id: id})}

  scope :by_county, -> {Location.joins(:addresses).order("addresses.county_id")}
  scope :by_city, -> {Location.joins(:addresses).order("addresses.city")}
  scope :by_zipcode, -> {Location.joins(:addresses).order("addresses.zipcode")}
  scope :by_updated, ->  {order('updated_at')}

  # scope :for_zipcode, -> (zip) { where("zipcode=?", zip ) }
  # scope :by_zipcode, -> { order('zipcode') }
  # scope :by_county, ->  { includes(:county).order('counties.name') }
  # scope :for_county, -> (id) { where('counties_id=?', id) }

  def item_locations_for_form
    collection = item_locations.where(location_id: id)
    collection.any? ? collection : item_locations.build
  end

  private

  def require_one_address
    errors.add(:base, "You must provide at least one address") if addresses.size < 1
  end

  def reformat_phone
    phone = self.phone.to_s  # change to string in case input as all numbers
    phone.gsub!(/[^0-9]/,"") # strip all non-digits
    self.phone = phone       # reset self.phone to new string
  end

end
