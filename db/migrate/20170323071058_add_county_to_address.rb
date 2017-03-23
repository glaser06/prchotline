class AddCountyToAddress < ActiveRecord::Migration[5.0]
  def change
    add_reference :addresses, :county, index: true, foreign_key: true
  end
end
