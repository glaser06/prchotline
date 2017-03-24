class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :context
      t.string :phone
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.boolean :active

      t.timestamps
    end
  end
end
