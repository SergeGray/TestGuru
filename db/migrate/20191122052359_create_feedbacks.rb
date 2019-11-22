class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.text :email, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
