require 'rails_helper'

RSpec.describe Admin::AnswersController, type: :controller do
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
  let(:question) do
    Question.create!(test: test, body: "Did you do it?")
  end
  let(:valid_attributes) { { question: question, body: "Yes", correct: true } }
  let(:invalid_attributes) { { question: question, body: "", correct: false } }

  context "when logged in as admin" do
    before(:each) do
      author.confirmed_at = Time.zone.now
      author.save!
      sign_in author
    end

    describe "GET #show" do
      it "returns a success response" do
        answer = Answer.create! valid_attributes
        get :show, params: { id: answer.to_param }
        expect(response).to be_successful
      end
    end

    describe "GET #new" do
      it "returns a success response" do
        get :new, params: { question_id: question.id }
        expect(response).to be_successful
      end
    end

    describe "GET #edit" do
      it "returns a success response" do
        answer = Answer.create! valid_attributes
        get :edit, params: { id: answer.to_param }
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Answer" do
          expect do
            post :create, params: {
              question_id: question.id, answer: valid_attributes
            }
          end.to change(Answer, :count).by(1)
        end

        it "redirects to the created answer" do
          post :create, params: {
            question_id: question.id, answer: valid_attributes
          }
          expect(response).to redirect_to(admin_answer_path(Answer.last))
        end
      end

      context "with invalid params" do
        it "returns a success response" do
          post :create, params: {
            question_id: question.id, answer: invalid_attributes
          }
          expect(response).to be_successful
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) { { body: "No", correct: false } }

        it "updates the requested answer" do
          answer = Answer.create! valid_attributes
          put :update, params: { id: answer.to_param, answer: new_attributes }
          answer.reload
          expect(answer.body).to eq(new_attributes[:body])
        end

        it "redirects to the answer" do
          answer = Answer.create! valid_attributes
          put :update, params: {
            id: answer.to_param, answer: valid_attributes
          }
          expect(response).to redirect_to(admin_answer_path(answer))
        end
      end

      context "with invalid params" do
        it "returns a success response" do
          answer = Answer.create! valid_attributes
          put :update, params: {
            id: answer.to_param, answer: invalid_attributes
          }
          expect(response).to be_successful
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested answer" do
        answer = Answer.create! valid_attributes
        expect do
          delete :destroy, params: { id: answer.to_param }
        end.to change(Answer, :count).by(-1)
      end

      it "redirects to the answers list" do
        answer = Answer.create! valid_attributes
        delete :destroy, params: { id: answer.to_param }
        expect(response).to redirect_to(admin_question_path(answer.question))
      end
    end
  end

  context "when not logged in" do
    describe "GET #new" do
      it "redirects to login page" do
        get :new, params: { question_id: question.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET #edit" do
      it "redirects to login page" do
        answer = Answer.create! valid_attributes
        get :edit, params: { id: answer.to_param }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "POST #create" do
      it "redirects to login page" do
        post :create, params: {
          question_id: question.id, answer: valid_attributes
        }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "PUT #update" do
      it "redirects to login page" do
        answer = Answer.create! valid_attributes
        put :update, params: {
          id: answer.to_param, answer: valid_attributes
        }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "DELETE #destroy" do
      it "redirects to login page" do
        answer = Answer.create! valid_attributes
        delete :destroy, params: { id: answer.to_param }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
