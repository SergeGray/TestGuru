require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name: "Sergey") }
  let(:category) { Category.create(title: "Web") }
  let(:tests) do
    Test.create!(
      [
        { title: "HTML", category_id: category.id, level: 1 },
        { title: "Javascript", category_id: category.id, level: 2 },
        { title: "CSS", category_id: category.id, level: 1 }
      ]
    )
  end

  describe "#started_by_level" do
    before(:each) do
      Attempt.create!(
        [
          { user_id: user.id, test_id: tests.first.id },
          { user_id: user.id, test_id: tests.second.id },
          { user_id: user.id, test_id: tests.third.id }
        ]
      )
    end

    it "returns all started tests with specified level" do
      expect(user.started_by_level(1)).to contain_exactly(
        tests.first, tests.third
      )
    end
  end
end
