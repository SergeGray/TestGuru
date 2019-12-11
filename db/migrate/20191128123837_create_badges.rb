class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.string :name, null: false
      t.string :image_url, null: false
      t.text :description
      t.integer :condition, null: false
      t.integer :condition_value, null: false

      t.timestamps
    end
  end
end
