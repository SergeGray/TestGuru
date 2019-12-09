class AddPassedFieldToAttempts < ActiveRecord::Migration[5.2]
  def change
    add_column :attempts, :passed, :boolean, default: :false
  end
end
