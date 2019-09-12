class Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_first_question, on: :create

  def accept!(answer_ids)
    if correct_answer?(answer_ids)
      correct_questions += 1
    end

    self.current_question = next_question
    save!
  end

  def completed?
    current_question.nil?
  end

  private

  def correct_answers
    current_question.answers.correct
  end

  def correct_answer?(answer_ids)
    correct_answers.sort == answer_ids.map(&:to_i).sort
  end

  def next_question
    test.questions.order(:id).find_by('id > ?', current_question.id)
  end

  def before_validation_set_first_question
    self.current_question = test.questions.first if test.present?
  end
end
