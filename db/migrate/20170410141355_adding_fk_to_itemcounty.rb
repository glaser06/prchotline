class AddingFkToItemcounty < ActiveRecord::Migration[5.0]
  def change
    add_reference :item_counties, :item, index: true, foreign_key: true
    add_reference :item_counties, :county, index: true, foreign_key: true
  end
end
