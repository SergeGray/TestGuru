require 'rails_helper'

RSpec.describe QuestionsHelper, type: :helper do
  let(:user) do
    User.create!(
      first_name: "Fred", email: "fred@yandex.ru", password: "fred4334"
    )
  end
  let(:category) { Category.create!(title: "Backend") }
  let(:test) { Test.create!(category: category, author: user, title: "Ruby") }

  describe "#question_header" do
    context "on an existing question" do
      it "outputs an editing header" do
        question = Question.create!(test: test, body: "Superclass of Class")
        expect(helper.question_header(question)).to eq(
          "Edit #{test.title} question"
        )
      end
    end

    context "on a new question" do
      it "outputs a creating header" do
        question = Question.new(test: test, body: "Class of Class")
        expect(helper.question_header(question)).to eq(
          "Create new #{test.title} question"
        )
      end
    end
  end
end
