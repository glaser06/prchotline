class CreateItemLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :item_locations do |t|
      t.string :description
      t.date :verified
      t.text :context

      t.timestamps
    end
  end
end
