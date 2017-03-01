class Addcountyid < ActiveRecord::Migration[5.0]
  def change
    add_reference :locations, :counties, foreign_key: true 
  end
end
