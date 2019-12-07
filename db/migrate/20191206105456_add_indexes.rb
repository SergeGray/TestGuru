class AddIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :badges, %i[condition condition_value], unique: true
  end
end
