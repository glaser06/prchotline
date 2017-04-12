class AddVerifiedToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :verified, :date
  end
end
