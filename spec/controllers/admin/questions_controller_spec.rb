require 'rails_helper'

RSpec.describe Admin::QuestionsController, type: :controller do
  let(:category) { Category.create!(title: "General") }
  let(:author) do
    User.create!(
      first_name: "Serge",
      last_name: "Shayderov",
      email: "s@example.com",
      password: "123123",
      type: "Admin"
    )
  end
  let(:test) do
    Test.create!(title: "Ruby", category: category, author: author)
  end
  let(:valid_attributes) do
    {
      body: "Who created Ruby language?",
      test: test,
      id: 1
    }
  end
  let(:invalid_attributes) { { body: "", test: test, id: 2 } }

  context "when logged in as admin" do
    before(:each) do
      author.confirmed_at = Time.zone.now
      author.save!
      sign_in author
    end

    describe "GET #show" do
      it "returns a success response" do
        question = Question.create!(valid_attributes)
        get :show, params: { id: question.to_param }
        expect(response).to be_successful
      end

      context "with invalid question" do
        it "returns a success response" do
          get :show, params: { id: 1_000_000 }
          expect(response).to be_successful
        end

        it "renders a not found message" do
          get :show, params: { id: 1_000_000 }
          expect(response.body).to eq("question not found")
        end
      end
    end

    describe "GET #new" do
      it "returns a success response" do
        get :new, params: { test_id: test.id }
        expect(response).to be_successful
      end
    end

    describe "GET #edit" do
      it "returns a success response" do
        question = Question.create! valid_attributes
        get :edit, params: { id: question.to_param }
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Question" do
          expect do
            post :create, params: {
              test_id: test.id, question: valid_attributes
            }
          end.to change(Question, :count).by(1)
        end

        it "redirects to question" do
          post :create, params: {
            test_id: test.id, question: valid_attributes
          }
          expect(response).to redirect_to(admin_question_path(Question.last))
        end
      end

      context "with invalid params" do
        it "returns a success response" do
          post :create, params: {
            test_id: test.id, question: invalid_attributes
          }
          expect(response).to be_successful
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) { { body: "Most popular Ruby web framework" } }

        it "updates the requested test" do
          question = Question.create! valid_attributes
          put :update, params: {
            id: question.to_param, question: new_attributes
          }
          question.reload
          expect(question.body).to eq(new_attributes[:body])
        end

        it "redirects to the test" do
          question = Question.create! valid_attributes
          put :update, params: {
            id: question.to_param, question: valid_attributes
          }
          expect(response).to redirect_to(admin_question_path(question))
        end
      end

      context "with invalid params" do
        it "returns a success response" do
          question = Question.create! valid_attributes
          put :update, params: {
            id: question.to_param, question: invalid_attributes
          }
          expect(response).to be_successful
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested question" do
        question = Question.create!(valid_attributes)
        expect do
          delete :destroy, params: { id: question.to_param }
        end.to change(Question, :count).by(-1)
      end
    end
  end

  context "when not logged in" do
    describe "GET #new" do
      it "redirects to login path" do
        get :new, params: { test_id: test.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET #edit" do
      it "redirects to login path" do
        question = Question.create! valid_attributes
        get :edit, params: { id: question.to_param }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "POST #create" do
      it "redirects to login path" do
        post :create, params: {
          test_id: test.id, question: invalid_attributes
        }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "PUT #update" do
      it "redirects to login path" do
        question = Question.create! valid_attributes
        put :update, params: {
          id: question.to_param, question: valid_attributes
        }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "DELETE #destroy" do
      it "redirects to login path" do
        question = Question.create!(valid_attributes)
        delete :destroy, params: { id: question.to_param }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
