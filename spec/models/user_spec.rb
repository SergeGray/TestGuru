require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) do
    User.create!(
      first_name: "Sergey", email: 'sergey@example.com', password: "W1b6vV"
    )
  end
  let(:admin) do
    User.create!(
      first_name: "Mark",
      last_name: "Zuckerberg",
      email: "overlord@facebook.com",
      password: "beepboop",
      type: "Admin"
    )
  end
  let!(:category) { Category.create!(title: "Web") }
  let!(:tests) do
    Test.create!(
      [
        { title: "HTML", category: category, level: 1, author: user },
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

  describe "dependent" do
    it "nullifies all created test foreign keys" do
      user.destroy
      tests.each do |test|
        test.reload
        expect(test.author).to be nil
      end
    end

    it "destroys all associated attempts" do
      user.destroy!
      attempts.each do |attempt|
        expect(Attempt.exists?(attempt.id)).to be false
      end
    end
  end

  describe "validates" do
    describe "name" do
      let(:valid_attributes) do
        { first_name: "Bob", email: "bob@bob.bob", password: "123456" }
      end
      let(:invalid_attributes) do
        { first_name: "", email: "invalid@fake.person", password: "qwerty" }
      end

      it "allows to create a user with a valid name" do
        new_user = User.new(valid_attributes)
        expect(new_user.valid?).to be true
      end

      it "disllows to create a user with an invalid name" do
        new_user = User.new(invalid_attributes)
        new_user.valid?
        expect(new_user.errors[:first_name]).to eq([BLANK_ERROR])
      end
    end

    describe "email" do
      let(:valid_attributes) do
        { first_name: "Bob", email: "bob@bob.bob", password: "123123" }
      end
      let(:invalid_attributes) do
        { first_name: "Bill", email: "", password: "666aaa" }
      end

      it "allows to create a user with a valid email" do
        new_user = User.new(valid_attributes)
        expect(new_user.valid?).to be true
      end

      it "disllows to create a user with an invalid email" do
        new_user = User.new(invalid_attributes)
        new_user.valid?
        expect(new_user.errors[:email]).to include(BLANK_ERROR)
      end

      it "disllows to create a user with an existing email" do
        User.create!(valid_attributes)
        new_user = User.new(valid_attributes)
        new_user.valid?
        expect(new_user.errors[:email]).to eq([TAKEN_ERROR])
      end
    end
  end

  describe "#started_by_level" do
    it "returns all started tests with specified level" do
      expect(user.started_by_level(1)).to contain_exactly(
        tests.first, tests.third
      )
    end
  end

  describe "#attempt" do
    it "given a test returns a user attempt" do
      expect(user.attempt(tests.first)).to eq(attempts.first)
    end
  end

  describe "#admin?" do
    it "returns true for admins" do
      expect(admin.admin?).to be true
    end

    it "returns false for regular users" do
      expect(user.admin?).to be false
    end
  end
end
