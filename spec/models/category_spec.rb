require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { Category.create!(title: "General") }

  describe "dependent" do
    let(:author) { User.create!(name: "Fred", email: "fred@fredcompany.org") }
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
      expect(new_category.valid?).to be false
    end
  end
end
