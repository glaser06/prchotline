class AddFkToAliases < ActiveRecord::Migration[5.0]
  def change
    # add reference to item
    # add column for active
    add_reference :aliases, :item, index: true, foreign_key: true
    add_column :aliases, :active, :boolean
  end
end
