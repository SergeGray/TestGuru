require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) do
    {
      name: "Bob",
      email: "bob@myspace.com",
      password: "qwerty",
      password_confirmation: "qwerty"
    }
  end
  let(:invalid_attributes) do
    {
      name: "Greg",
      email: "greg@myspace.com",
      password: "qwerty",
      password_confirmation: "qwefty"
    }
  end
  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "successfully creates a new user" do
        expect do
          post :create, params: { user: valid_attributes }
        end.to change(User, :count).by(1)
      end

      it "redirects to root" do
        post :create, params: { user: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      it "returns a success response" do
        post :create, params: { user: invalid_attributes }
        expect(response).to be_successful
      end

      it "doesn't create a new user" do
        expect do
          post :create, params: { user: invalid_attributes }
        end.to_not change(User, :count)
      end
    end
  end
end
