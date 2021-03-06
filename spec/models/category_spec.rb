require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { Category.create!(title: "General") }

  describe "dependent" do
    let(:author) do
      User.create!(
        first_name: "Fred", email: "fred@fredcompany.org", password: "123456"
      )
    end
    let(:test) { Test.create!(title: "Ruby", category: category, author: author) }

    it "nullifies foreign keys for its tests upon destruction" do
      category.destroy!
      test.reload
      expect(test.category).to be nil
    end
  end

  describe "validate" do
    let(:valid_attributes) { { title: "Web Development" } }
    let(:invalid_attributes) { { title: "" } }

    it "allows to create a category with a valid title" do
      new_category = Category.new(valid_attributes)
      expect(new_category.valid?).to be true
    end

    it "disallows to create a category with an invalid title" do
      new_category = Category.new(invalid_attributes)
      new_category.valid?
      expect(new_category.errors[:title]).to eq([BLANK_ERROR])
    end

    it "disallows to create a category with an existing title" do
      Category.create!(valid_attributes)
      new_category = Category.new(valid_attributes)
      new_category.valid?
      expect(new_category.errors[:title]).to eq([TAKEN_ERROR])
    end
  end
end
