class County < ApplicationRecord

  # Callbacks
  before_save :reformat_county_name

  has_many :item_counties, dependent: :destroy
  has_many :items, through: :item_counties
  has_many :addresses, dependent: :destroy

  validates_presence_of :name

  scope :alphabetical, -> { order('name') }
  scope :for_name, -> (name) { where('name=?',name) }

  private

  def reformat_county_name
    name = self.name.capitalize
    self.name = name
  end

end
