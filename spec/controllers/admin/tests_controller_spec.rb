require 'rails_helper'

RSpec.describe Admin::TestsController, type: :controller do
  let!(:category) { Category.create!(title: "Backend", id: 1) }
  let!(:author) do
    User.create!(
      first_name: "Serge",
      last_name: "Shayderov",
      email: "mail@mail.mail",
      password: "123123",
      id: 1,
      type: "Admin"
    )
  end
  let(:valid_attributes) do
    { title: "Ruby", category_id: 1, level: 0, author_id: 1 }
  end
  let(:invalid_attributes) do
    { title: "Rust", category_id: 1, level: -1, author_id: 1 }
  end

  context "when logged in as admin" do
    before(:each) do
      author.confirmed_at = Time.zone.now
      author.save!
      sign_in author
    end

    describe "GET #index" do
      it "returns a success response" do
        Test.create! valid_attributes
        get :index
        expect(response).to be_successful
      end
    end

    describe "GET #show" do
      it "returns a success response" do
        test = Test.create! valid_attributes
        get :show, params: { id: test.to_param }
        expect(response).to be_successful
      end
    end

    describe "GET #new" do
      it "returns a success response" do
        get :new
        expect(response).to be_successful
      end
    end

    describe "GET #edit" do
      it "returns a success response" do
        test = Test.create! valid_attributes
        get :edit, params: { id: test.to_param }
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Album" do
          expect do
            post :create, params: { test: valid_attributes }
          end.to change(Test, :count).by(1)
        end

        it "redirects to the created test" do
          post :create, params: { test: valid_attributes }
          expect(response).to redirect_to(admin_test_path(Test.last))
        end
      end

      context "with invalid params" do
        it "returns a success response" do
          post :create, params: { test: invalid_attributes }
          expect(response).to be_successful
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) { { title: "Ruby on Rails", level: 1 } }

        it "updates the requested test" do
          test = Test.create! valid_attributes
          put :update, params: { id: test.to_param, test: new_attributes }
          test.reload
          expect(test.title).to eq(new_attributes[:title])
        end

        it "redirects to the test" do
          test = Test.create! valid_attributes
          put :update, params: { id: test.to_param, test: valid_attributes }
          expect(response).to redirect_to(admin_test_path(test))
        end
      end

      context "with invalid params" do
        it "returns a success response" do
          test = Test.create! valid_attributes
          put :update, params: { id: test.to_param, test: invalid_attributes }       
          expect(response).to be_successful
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested test" do
        test = Test.create! valid_attributes
        expect do
          delete :destroy, params: { id: test.to_param }
        end.to change(Test, :count).by(-1)
      end

      it "redirects to the tests list" do
        test = Test.create! valid_attributes
        delete :destroy, params: { id: test.to_param }
        expect(response).to redirect_to(admin_tests_url)
      end
    end
  end

  context "when not logged in" do
    describe "GET #new" do
      it "redirects to login path" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET #edit" do
      it "redirects to login path" do
        test = Test.create! valid_attributes
        get :edit, params: { id: test.to_param }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "POST #create" do
      it "redirects to login path" do
        post :create, params: { test: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "PUT #update" do
      it "redirects to login path" do
        test = Test.create! valid_attributes
        put :update, params: { id: test.to_param, test: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "DELETE #destroy" do
      it "redirects to login path" do
        test = Test.create! valid_attributes
        delete :destroy, params: { id: test.to_param }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
