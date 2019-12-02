class CreateUserBadgesJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :user_badges do |t|
      t.integer :user_id, null: false
      t.integer :badge_id, null: false
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
