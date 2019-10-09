require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#current_year" do
    it "returns current year" do
      expect(helper.current_year).to eq(Time.zone.now.year)
    end
  end

  describe "#github_url" do
    it "giver author and repository name, returns github url" do
      expect(helper.github_url("Bob", "TestGuru")).to eq(
        "https://github.com/Bob/TestGuru"
      )
    end
  end

  describe "#flash_message" do
    it "generates a content tag for flash message of specified type" do
      expect(flash_message("Hello", :greet)).to eq(
        content_tag(:div, "Hello", class: "flash greet")
      )
    end
  end
end
