class CreateItemCounties < ActiveRecord::Migration[5.0]
  def change
    create_table :item_counties do |t|
      t.string :description

      t.timestamps
    end
  end
end
