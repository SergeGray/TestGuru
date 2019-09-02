class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :validate_number_of_answers, on: :create

  scope :correct, -> { where(correct: true) }

  private

  def validate_number_of_answers
    return if question.answers.count >= 4

    errors.add(:question, "already has 4 answers")
  end
end
