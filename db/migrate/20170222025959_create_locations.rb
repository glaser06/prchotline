class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :website
      t.string :city
      t.string :zipcode
      t.string :state

      t.timestamps
    end
  end
end
