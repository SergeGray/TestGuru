class CreateUserBadgesTestsJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :user_badge_tests do |t|
      t.integer :user_badge_id, null: false
      t.integer :test_id, null: false

      t.timestamps
    end
  end
end
