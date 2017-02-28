class AddActiveToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :active, :boolean
  end
end
