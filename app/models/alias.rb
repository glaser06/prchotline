class Alias < ApplicationRecord

  belongs_to :item

  scope :for_name, -> (name) { where("name=?", name) }
  scope :alphabetical, -> { order('name') }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

end
