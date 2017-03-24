class Address < ApplicationRecord
  # before_save :reformat_phone

  belongs_to :location
  belongs_to :county

  validates :address, :city, :zipcode, :location, :county, presence: true

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :for_zipcode, -> (zip) { where("zipcode=?", zip ) }
  scope :by_zipcode, -> { order('zipcode') }
  scope :for_county, -> (id) { where('county_id=?', id) }
  scope :by_city, -> (id) { order('city') }



  geocoded_by :zipcode
  # after_validation :geocode

  def full_address
    address = "#{self.address} #{self.city}, PA #{self.zipcode}"
    return address
  end



end
