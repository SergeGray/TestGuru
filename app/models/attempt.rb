class Attempt < ApplicationRecord
  PASSING_SCORE = 85

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_current_question

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)

    save!
  end

  def completed?
    current_question.nil?
  end

  def current_question_index
    test.questions.index(current_question)
  end

  def total_questions
    test.questions.count
  end

  def score
    (100.0 * correct_questions / total_questions).round(2)
  end

  def successful?
    score > 85
  end

  def progress
    100 * (current_question_index + 1) / total_questions
  end

  private

  def correct_answers
    current_question.answers.correct
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == Array(answer_ids).map(&:to_i).sort
  end

  def next_question
    if current_question
      test.questions.where('id > ?', current_question.id).first
    else
      test.questions.first
    end
  end

  def before_validation_set_current_question
    self.current_question = next_question
  end
end
