require 'rails_helper'

RSpec.describe Answer, type: :model do
  let!(:category) { Category.create!(title: "General") }
  let!(:author) { User.create!(name: "Serge", email: "serge@example.com") }
  let!(:test) { Test.create!(title: "Ruby", category: category, author: author) }
  let!(:question) do
    Question.create!(
      body: "Is Ruby an Object Oriented Programming language?",
      test: test,
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

  describe ".correct" do
    it "returns a collection of all correct answers" do
      expect(Answer.correct).to contain_exactly(answers.third)
    end
  end
end
