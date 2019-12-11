class RestructureUserBadgesTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_badges, :completed, :boolean, default: false
    remove_column :user_badges, :progress, :integer, default: 0, null: false
  end
end
