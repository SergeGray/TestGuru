require 'rails_helper'

RSpec.describe TestsController, type: :controller do
  let!(:category) { Category.create!(title: "Backend", id: 1) }
  let!(:author) do
    User.create!(
      first_name: "Serge", email: "mail@mail.mail", password: "123123", id: 1
    )
  end
  let(:valid_attributes) do
    { title: "Ruby", category_id: 1, level: 0, author_id: 1 }
  end
  let(:invalid_attributes) do
    { title: "Rust", category_id: 1, level: -1, author_id: 1 }
  end

  describe "GET #index" do
    it "returns a success response" do
      Test.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe "POST #start" do
    context "when logged in" do
      before(:each) do
        author.confirmed_at = Time.zone.now
        author.save!
        sign_in author
      end

      it "starts the requested test" do
        test = Test.create! valid_attributes
        expect do
          post :start, params: { id: test.to_param }
        end.to change(Attempt, :count).by(1)
      end
    end

    context "when not logged in" do
      it "redirects to login path" do
        test = Test.create! valid_attributes
        post :start, params: { id: test.to_param }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
