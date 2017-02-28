class AddActiveToItemLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :item_locations, :active, :boolean
  end
end
