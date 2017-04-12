class AddCountyCoordinatorInfoToCounties < ActiveRecord::Migration[5.0]
  def change
    add_column :counties, :coordinator, :string
    add_column :counties, :phone, :string
    add_column :counties, :website, :string
  end
end
