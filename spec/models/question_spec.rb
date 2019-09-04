require 'rails_helper'

RSpec.describe Question, type: :model do
  let!(:category) { Category.create!(title: "General") }
  let!(:author) { User.create!(name: "Serge", email: "serge@example.com") }
  let!(:test) { Test.create!(title: "Ruby", category: category, author: author) }
  let!(:question) do
    Question.create!(
      body: "Who created Ruby language?",
      test: test
    )
  end

  describe "dependent" do
    it "destroys associated answers" do
      answer = Answer.create!(body: "Matz", correct: true, question: question)
      question.destroy!
      expect(Answer.exists?(answer.id)).to be false
    end
  end

  describe "validate" do
    let(:valid_attributes) do
      { body: "Difference between puts and print", test: test }
    end
    let(:invalid_attributes) { { body: "", test: test } }

    describe "body" do
      it "allows to create a question with a valid title" do
        question = Question.new(valid_attributes)
        expect(question.valid?).to be true
      end

      it "disallows to create a question with an invalid title" do
        question = Question.new(invalid_attributes)
        expect(question.valid?).to be false
      end
    end
  end
end
