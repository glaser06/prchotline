class AddDetailsToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :details, :string
  end
end
