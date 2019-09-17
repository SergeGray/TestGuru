class RemoveScoreAndFinishedColumnsFromAttempts < ActiveRecord::Migration[5.2]
  def change
    remove_column :attempts, :score, :integer, null: false, default: 0
    remove_column :attempts, :finished, :boolean, null: false, default: false
  end
end
