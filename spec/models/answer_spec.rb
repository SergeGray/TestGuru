require 'rails_helper'

RSpec.describe Answer, type: :model do
  let!(:category) { Category.create!(title: "General") }
  let!(:author) { User.create!(name: "Serge", email: "serge@example.com") }
  let!(:test) { Test.create!(title: "Ruby", category: category, author: author) }
  let!(:question) do
    Question.create!(
      body: "Is Ruby an Object Oriented Programming language?",
      test: test
    )
  end
  let!(:answers) do
    Answer.create!(
      [
        { body: "Maybe", question: question },
        { body: "No", question: question },
        { body: "Yes", question: question, correct: true }
      ]
    )
  end

  describe "validate" do
    let(:valid_attributes) { { body: "12", question: question } }
    let(:invalid_attributes) { { body: "", question: question } }

    describe "title" do
      it "allows to create an answer with a valid body" do
        answer = Answer.new(valid_attributes)
        expect(answer.valid?).to be true
      end

      it "disallows to create an answer with an invalid body" do
        answer = Answer.new(invalid_attributes)
        expect(answer.valid?).to be false
      end
    end

    describe "question" do
      it "disallows to create more than 4 answers for the same question" do
        Answer.create!(valid_attributes)
        answer = Answer.new(body: "Skip", question: question)
        expect(answer.valid?).to be false
      end
    end
  end

  describe ".correct" do
    it "returns a collection of all correct answers" do
      expect(Answer.correct).to contain_exactly(answers.third)
    end
  end
end
