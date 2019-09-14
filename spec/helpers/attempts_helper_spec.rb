require 'rails_helper'

RSpec.describe AttemptsHelper, type: :helper do
  let(:user) { User.create!(name: "Fred", email: "fred@yandex.ru") }
  let(:category) { Category.create!(title: "Backend") }
  let(:test) { Test.create!(category: category, author: user, title: "Ruby") }
  let!(:question) { test.questions.create!(body: "When was Ruby created") }
  let!(:answer) { question.answers.create!(body: "1995", correct: true) }
  let(:attempt) { Attempt.create!(test: test, user: user) }

  describe "#result" do
    context "with passing score" do
      it "returns result with green font and passing message" do
        attempt.accept!([answer.id])
        expect(helper.result(attempt)).to eq(
          "<font color=#00FF00>100.0% - passed</font>"
        )
      end
    end

    context "with failing score" do
      it "returns result with red font and failing message" do
        expect(helper.result(attempt)).to eq(
          "<font color=#FF0000>0.0% - failed</font>"
        )
      end
    end
  end

  describe "#progress" do
    it "returns progress on the test" do
      expect(helper.progress(attempt)).to eq("1/1")
    end
  end
end
