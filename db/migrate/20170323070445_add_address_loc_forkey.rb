class AddAddressLocForkey < ActiveRecord::Migration[5.0]
  def change
    add_reference :addresses, :location, index: true, foreign_key: true
  end
end
