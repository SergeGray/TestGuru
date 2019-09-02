require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { User.create(name: "Sergey", id: 1) }
  let!(:category) { Category.create(title: "Web", id: 1) }
  let!(:tests) do
    Test.create!(
      [
        { title: "HTML", category_id: 1, level: 1, author_id: 1, id: 1 },
        { title: "Javascript", category_id: 1, level: 2, author_id: 1, id: 2 },
        { title: "CSS", category_id: 1, level: 1, author_id: 1, id: 3 }
      ]
    )
  end
  let!(:attempts) do
    Attempt.create!(
      [
        { user_id: 1, test_id: 1 },
        { user_id: 1, test_id: 2 },
        { user_id: 1, test_id: 3 }
      ]
    )
  end

  describe "#started_by_level" do
    it "returns all started tests with specified level" do
      expect(user.started_by_level(1)).to contain_exactly(
        tests.first, tests.third
      )
    end
  end
end
