class CreateAttempts < ActiveRecord::Migration[5.2]
  def change
    create_table :attempts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :test, null: false, foreign_key: true
      t.integer :score, null: false, default: 0
      t.boolean :finished, null: false, default: false

      t.timestamps
    end
  end
end
