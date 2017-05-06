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

  # What does this actually do?
  geocoded_by :full_address

  # Shouldn't some of these actually be private methods????
  def require_one_address
    location.addresses.count > 1
  end

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
