class ItemlocationFk < ActiveRecord::Migration[5.0]
  def change

    add_reference :item_locations, :item, foreign_key: true
    add_reference :item_locations, :location, foreign_key: true
    add_column :item_locations, :reason, :text

    # add_column :locaions, :county_id, :integer

  end
end
