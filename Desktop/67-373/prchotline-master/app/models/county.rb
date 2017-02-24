class County < ApplicationRecord

  # Relationships
  has_many :items, through: :item_counties


  # Validations
  validates_presence_of :name

  # Scopes
  scope :alphabetical, -> { order('name') }



    def self.search(search)
      print search
      if search
        find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
      else
        find(:all)
      end
    end
end
