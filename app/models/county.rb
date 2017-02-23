class County < ApplicationRecord

    # Relationships
    has_many :items, through: :item_counties
end
