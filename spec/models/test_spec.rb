require 'rails_helper'

RSpec.describe Test, type: :model do
  let!(:author) { User.create(name: "Bob", email: 'bob@google.com') }
  let!(:categories) do
    Category.create!(
      [
        { title: "General", id: 1 },
        { title: "Web Development", id: 2 }
      ]
    )
  end
  let!(:tests) do
    Test.create!(
      [
        { id: 1, title: "Ruby", category: categories.first, author: author },
        { id: 2, title: "Lua", category: categories.first, author: author },
        { id: 3, title: "Javascript", category: categories.second, author: author }
      ]
    )
  end

  describe ".of_category" do
    it "returns all tests that belong to specified category" do
      expect(Test.of_category(categories.first.title)).to eq(
        [tests.second.title, tests.first.title]
      )
    end
  end
end
