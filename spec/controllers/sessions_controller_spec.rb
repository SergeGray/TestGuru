require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let!(:user) do
    User.create!(name: "Serge", email: "s@example.com", password: "123123")
  end

  let(:valid_attributes) { { email: "s@example.com", password: "123123" } }
  let(:invalid_attributes) { { email: "s@example.com", password: "123456" } }

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates an entry in the session" do
        post :create, params: valid_attributes
        expect(session).to have_key(:user_id)
      end

      context "when redirected from a path" do
        let(:path) { new_test_path }

        it "redirects to path you were redirected from" do
          cookies[:path] = path
          post :create, params: valid_attributes
          expect(response).to redirect_to(path)
        end
      end

      context "when directly visiting login page" do
        it "redirects to root" do
          post :create, params: valid_attributes
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context "with invalid params" do
      it "returns a success response" do
        post :create, params: invalid_attributes
        expect(response).to be_successful
      end

      it "flashes a fail login message" do
        post :create, params: invalid_attributes
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    it "removes user entry from the session" do
      delete :destroy
      expect(session).to_not have_key(:user_id)
    end
  end
end
