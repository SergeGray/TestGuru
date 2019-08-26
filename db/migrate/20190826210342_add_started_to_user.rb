class AddStartedToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :started, :integer, array: true, default: []
  end
end
