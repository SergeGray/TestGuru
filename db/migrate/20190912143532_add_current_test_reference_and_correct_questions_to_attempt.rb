class AddCurrentTestReferenceAndCorrectQuestionsToAttempt < ActiveRecord::Migration[5.2]
  def change
    add_column :attempts, :correct_questions, :integer, default: 0
    add_reference :attempts, :current_question,
                  foreign_key: { to_table: :questions }
  end
end
