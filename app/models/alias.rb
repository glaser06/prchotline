class Alias < ApplicationRecord

  before_save :downcase_name

  belongs_to :item, required: false

  scope :for_name, -> (name) { where("name=?", name) }
  scope :alphabetical, -> { order('name') }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  private 

      def downcase_name
        self.name = self.name.downcase
      end

end
