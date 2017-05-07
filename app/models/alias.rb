class Alias < ApplicationRecord


  # Callbacks
  before_save :downcase_name

  # Relationships
  belongs_to :item, required: false

  # Scopes
  scope :for_name, -> (name) { where("name=?", name) }

  # and why do we need an alias alphabetical scope??????
  scope :alphabetical, -> { order('name') }

  ### why can an alias be active or inactive????????????
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  private
    def downcase_name
      self.name = self.name.downcase
    end

end
