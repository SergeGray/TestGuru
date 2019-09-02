require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { User.create(name: "Sergey", email: 'sergey@example.com') }
  let!(:category) { Category.create(title: "Web") }
  let!(:tests) do
    Test.create!(
      [
        { title: "HTML", category: category, level: 1, author: user},
        { title: "Javascript", category: category, level: 2, author: user },
        { title: "CSS", category: category, level: 1, author: user }
      ]
    )
  end
  let!(:attempts) do
    Attempt.create!(
      [
        { user: user, test: tests.first },
        { user: user, test: tests.second },
        { user: user, test: tests.third }
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
