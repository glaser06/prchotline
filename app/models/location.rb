class Location < ApplicationRecord

  before_save :reformat_phone

  has_many :item_locations, dependent: :destroy
  has_many :items, through: :item_locations
  has_many :addresses, :autosave => true, dependent: :destroy
  has_many :counties, through: :addresses

  accepts_nested_attributes_for :item_locations, reject_if: lambda { |item_location| item_location[:item_id].blank? }, allow_destroy: true
  accepts_nested_attributes_for :addresses, reject_if: lambda { |addr| addr[:address].blank? }, allow_destroy: true

  validates :name, presence: true
  validates :addresses, presence: true
  validates_format_of :phone, with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "should be 10 digits (area code needed) and delimited with dashes only", allow_blank: true
  validate :require_one_address

  scope :alphabetical , -> { order('name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :for_county, -> (id) {joins(:addresses).where(addresses: {county_id: id})}
  scope :for_item, -> (id) {joins(:item_locations).where(item_locations: {item_id: id})}
  scope :by_county, -> {joins(:addresses).order("addresses.county_id")}
  scope :by_city, -> {joins(:addresses).order("addresses.city")}
  scope :by_zipcode, -> {joins(:addresses).order("addresses.zipcode")}
  scope :by_updated, ->  {order('updated_at')}
  scope :by_active, ->  {order('active')}

  def item_locations_for_form
    collection = item_locations.where(location_id: id)
    collection.any? ? collection : item_locations.build
  end

  def link_to_website

    if self.website && self.website.length > 5
      if self.website[0...4] == "http"
        return self.website
      else
        return "http://#{website}"
      end
    end

  end

  private

  def require_one_address
    errors.add(:base, "You must provide at least one address") if addresses.size < 1
  end



  def reformat_phone
    phone = self.phone.to_s
    phone.gsub!(/[^0-9]/,"")
    self.phone = phone
  end

end
