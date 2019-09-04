require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  let(:category) { Category.create!(title: "General") }
  let(:author) { User.create!(name: "Serge", email: "s@example.com") }
  let(:test) do
    Test.create!(title: "Ruby", category: category, author: author)
  end
  let(:valid_attributes) do
    {
      body: "Who created Ruby language?",
      test: test
    }
  end
  let(:invalid_attributes) { { body: "", test: test } }

  describe "GET #index" do
    it "returns a success response" do
      Question.create!(valid_attributes)
      get :index, params: { test_id: test.id }
      expect(response).to be_successful
    end
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

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Question" do
        expect do
          post :create, params: { test_id: test.id, question: valid_attributes }
        end.to change(Question, :count).by(1)
      end

      it "redirects to Test questions" do
        post :create, params: { test_id: test.id, question: valid_attributes }
        expect(response).to redirect_to(test_questions_path(test))
      end
    end

    context "with invalid params" do
      it "returns a success response" do
        post :create, params: { test_id: test.id, question: invalid_attributes }
        expect(response).to be_successful
      end

      it "renders a fail response" do
        post :create, params: { test_id: test.id, question: invalid_attributes }
        expect(response.body).to eq("failed to save question")
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

    it "renders a response" do
      question = Question.create!(valid_attributes)
      delete :destroy, params: { id: question.to_param }
      expect(response.body).to eq("question destroyed")
    end
  end
end
