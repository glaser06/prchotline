class RemoveAddressFromLoc < ActiveRecord::Migration[5.0]
  def up
    remove_column :locations, :address
    remove_column :locations, :city
    remove_column :locations, :zipcode
    remove_column :locations, :state
    remove_column :locations, :counties_id

  end
  def down
    add_column :locations, :address, :string
    add_column :locations, :city, :string
    add_column :locations, :zipcode, :string
    add_column :locations, :state, :string

  end

end
