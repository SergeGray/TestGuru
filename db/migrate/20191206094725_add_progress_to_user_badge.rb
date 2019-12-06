class AddProgressToUserBadge < ActiveRecord::Migration[5.2]
  def change
    add_column :user_badges, :progress, :integer, null: false, default: 0
  end
end
