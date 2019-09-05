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
        {
          id: 1,
          title: "Ruby",
          category: categories.first,
          author: author,
          level: 1
        }, {
          id: 2,
          title: "Lua",
          category: categories.first,
          author: author,
          level: 4
        },
        {
          id: 3,
          title: "Javascript",
          category: categories.second,
          author: author,
          level: 8
        }
      ]
    )
  end

  describe "dependent" do
    it "destroys associated questions" do
      question = Question.create!(
        body: "Interpolation syntax", test: tests.first
      )
      tests.first.destroy!
      expect(Question.exists?(question.id)).to be false
    end

    it "destroys associated attempts" do
      attempt = Attempt.create!(user: author, test: tests.first)
      tests.first.destroy!
      expect(Attempt.exists?(attempt.id)).to be false
    end
  end

  describe "validates" do
    describe "title" do
      let(:valid_attributes) do
        { title: "C", category: categories.first, author: author }
      end
      let(:invalid_attributes) do
        { title: "", category: categories.first, author: author }
      end

      it "allows to create a test with a valid title" do
        new_test = Test.new(valid_attributes)
        expect(new_test.valid?).to be true
      end

      it "disallows to create a test with an invalid title" do
        new_test = Test.new(invalid_attributes)
        new_test.valid?
        expect(new_test.errors[:title]).to eq([BLANK_ERROR])
      end
    end

    describe "level" do
      let(:valid_attributes) do
        { title: "Lua", level: 2, category: categories.first, author: author }
      end
      let(:level_lower_than_0) do
        { title: "C#", level: -1, category: categories.first, author: author }
      end
      let(:float_level) do
        { title: "C++", level: 1.1, category: categories.first, author: author }
      end

      it "allows to create a test with a valid level" do
        new_test = Test.new(valid_attributes)
        expect(new_test.valid?).to be true
      end

      it "disallows to create a test with a negative level" do
        new_test = Test.new(level_lower_than_0)
        new_test.valid?
        expect(new_test.errors[:level]).to eq(
          [
            "must be greater than or equal to 0"
          ]
        )
      end

      it "disallows to create a test with a float" do
        new_test = Test.new(float_level)
        new_test.valid?
        expect(new_test.errors[:level]).to eq(["must be an integer"])
      end
    end

    describe "unique_title_level" do
      let(:valid_attributes) do
        { title: "Rust", level: 5, category: categories.first, author: author }
      end
      let(:different_level) do
        { title: "Rust", level: 6, category: categories.first, author: author }
      end

      it "allows to create a test with same name but different level" do
        Test.create!(valid_attributes)
        new_test = Test.new(different_level)
        expect(new_test.valid?).to be true
      end

      it "disallows to create a test with same name and level" do
        Test.create!(valid_attributes)
        new_test = Test.new(valid_attributes)
        new_test.valid?
        expect(new_test.errors[:title]).to eq([TAKEN_ERROR])
      end
    end
  end

  describe ".of_level" do
    it "returns all tests with given level" do
      expect(Test.of_level(1)).to contain_exactly(tests.first)
    end
  end

  describe ".easy" do
    it "returns all tests with easy level (0..1)" do
      expect(Test.easy).to contain_exactly(tests.first)
    end
  end

  describe ".medium" do
    it "returns all tests with medium level (2..4)" do
      expect(Test.medium).to contain_exactly(tests.second)
    end
  end

  describe ".hard" do
    it "returns all tests with hard level (5 and up)" do
      expect(Test.hard).to contain_exactly(tests.third)
    end
  end

  describe ".of_category" do
    it "returns an array of titles of tests that belong to given category" do
      expect(Test.titles_of_category(categories.first.title)).to eq(
        [tests.second.title, tests.first.title]
      )
    end
  end
end
