class AddIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :badges, %i[condition, condition_value], unique: true
    add_index :user_badge_tests, %i[user_badge_id, test_id], unique: true
  end
end
