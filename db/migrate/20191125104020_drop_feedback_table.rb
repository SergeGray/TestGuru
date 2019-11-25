class DropFeedbackTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :feedbacks do |t|
      t.text :email, null: false
      t.text :content, null: false
    end
  end
end
