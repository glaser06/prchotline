class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.string :rails
      t.string :g
      t.string :scaffold
      t.string :County
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
