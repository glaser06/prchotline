class Address < ApplicationRecord

  # Relationships
  belongs_to :location, required: false
  belongs_to :county

  # Validations
  validates :address, :county, presence: true

  # Scopes

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :for_zipcode, -> (zip) { where("zipcode=?", zip ) }
  scope :by_zipcode, -> { order('zipcode') }
  scope :for_county, -> (id) { where('county_id=?', id) }
  scope :by_name, -> { joins(:location).order('locations.name')}
  scope :by_verified, -> { joins(:location).order('locations.updated_at')}
  scope :by_county, -> { order('county_id') }
  scope :by_city, -> { order('city') }
  scope :by_active, -> {order('active DESC')}



  # uses the full address to find the lat and long of
  # the Address. For use in zipcode search by distance.
  geocoded_by :full_address
  # updates the lat and long field after validation
  # DO NO ENABLE DURING SEEDING
  # - google maps api limit is 50 requests/second
  after_validation :geocode

  def full_address
    "#{self.address}, #{self.city}, PA #{self.zipcode}"
  end

  def street_address
    "#{self.address}"
  end

  def extra_details
    "#{self.city}, PA #{self.zipcode}"
  end

end
