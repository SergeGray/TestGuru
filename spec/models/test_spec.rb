require 'rails_helper'

RSpec.describe Test, type: :model do
  let(:categories) do
    Category.create!(
      [
        { title: "General", id: 1 },
        { title: "Web Development", id: 2 }
      ]
    )
  end
  let(:tests) do
    Test.create!(
      [
        { id: 1, title: "Ruby", category_id: 1 },
        { id: 2, title: "Lua", category_id: 1 },
        { id: 3, title: "Javascript", category_id: 2 }
      ]
    )
  end

  describe ".of_category" do
    it "returns all tests that belong to specified category" do
      expect(Test.of_category(categories.first)).to contain_exactly(
        tests.first, tests.second
      )
    end
  end
end
