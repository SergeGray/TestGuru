require 'rails_helper'

RSpec.describe Attempt, type: :model do
  let(:user) do
    User.create!(
      first_name: "Bob", email: "bob@google.com", password: "qwerty"
    )
  end
  let(:category) { Category.create!(title: "General") }
  let(:test) do
    Test.create!(category: category, author: user, title: "Python")
  end
  let!(:questions) do
    test.questions.create!(
      [
        { body: "Name of the orderless collection data type" },
        { body: "String method used for interpolation" }
      ]
    )
  end
  let(:answers) do
    questions.first.answers.create!(
      [
        { body: "tuple", correct: true, id: 1 },
        { body: "list", correct: false, id: 2 }
      ]
    )
  end
  describe "before_validation" do
    it "sets current_question to the first question in test" do
      attempt = Attempt.new(user: user, test: test)
      attempt.valid?
      expect(attempt.current_question).to eq(questions.first)
    end
  end

  describe "before_save" do
    it "sets current_question to the next question in test" do
      attempt = Attempt.create!(user: user, test: test)
      attempt.save!
      expect(attempt.current_question).to eq(questions.second)
    end
  end

  describe "#accept!" do
    context "with correct answer ids" do
      it "increases the correct answer counter" do
        attempt = Attempt.create!(user: user, test: test)
        expect do
          attempt.accept!([answers.first.id])
        end.to change(attempt, :correct_questions).by(1)
      end
    end

    context "with incorrect answer ids" do
      it "doesn't increase the correct answer counter" do
        attempt = Attempt.create!(user: user, test: test)
        expect do
          attempt.accept!([answers.first.id, answers.second.id])
        end.to_not change(attempt, :correct_questions)
      end
    end
  end

  describe "#completed?" do
    context "when test is in progress" do
      it "returns false" do
        attempt = Attempt.create!(user: user, test: test)
        expect(attempt.completed?).to be false
      end
    end

    context "when test is completed" do
      it "returns true" do
        attempt = Attempt.create!(user: user, test: test)
        2.times { attempt.save! }
        expect(attempt.completed?).to be true
      end
    end
  end

  describe "#current_question_index" do
    it "returns index of the current question in the test" do
      attempt = Attempt.create!(user: user, test: test)
      expect(attempt.current_question_index).to eq(0)
    end
  end

  describe "#total_question" do
    it "returns a number of questions in the test" do
      attempt = Attempt.create!(user: user, test: test)
      expect(attempt.total_questions).to eq(questions.size)
    end
  end

  describe "#score" do
    it "returns a percentage of correctly answered questions" do
      attempt = Attempt.create!(user: user, test: test)
      attempt.accept!([answers.first.id])
      expect(attempt.score).to eq(50)
    end
  end
end
