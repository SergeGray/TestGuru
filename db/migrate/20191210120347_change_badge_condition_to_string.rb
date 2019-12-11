class ChangeBadgeConditionToString < ActiveRecord::Migration[5.2]
  def self.up
    change_column :badges, :condition, :string
  end

  def self.down
    change_column :badges, :condition, :integer
  end
end
