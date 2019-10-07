require 'rails_helper'

RSpec.describe AttemptsController, type: :controller do
  let(:category) { Category.create!(title: "General") }
  let(:user) do
    User.create!(name: "Serge", email: "s@example.com", password: "123123")
  end
  let(:test) do
    Test.create!(title: "Ruby", category: category, author: user)
  end
  let!(:question) do
    Question.create!(test: test, body: "Did you do it?")
  end
  let(:attributes) { { test: test, user: user } }

  describe "GET #result" do
    it "returns a success response" do
      attempt = Attempt.create!(attributes)
      get :result, params: { id: attempt.to_param }
      expect(response).to be_successful
    end
  end

  context "when logged in" do
    let(:logged_in) { { user_id: user.id } }

    describe "GET #show" do
      it "returns a success response" do
        attempt = Attempt.create!(attributes)
        get :show, params: { id: attempt.to_param }, session: logged_in
        expect(response).to be_successful
      end
    end

    describe "POST #update" do
      context "When test isn't completed" do
        it "renders #show again" do
          test.questions.create!(body: "What did it cost?")
          attempt = Attempt.create!(attributes)
          get :update,
              params: { id: attempt.to_param, answer_ids: [] },
              session: logged_in
          expect(response).to be_successful
        end
      end

      context "When test is completed" do
        it "redirects to result" do
          attempt = Attempt.create!(attributes)
          get :update,
              params: { id: attempt.to_param, answer_ids: [] },
              session: logged_in
          expect(response).to redirect_to(result_attempt_url(attempt))
        end
      end
    end
  end

  context "when not logged in" do
    describe "GET #show" do
      it "redirects to login path" do
        attempt = Attempt.create!(attributes)
        get :show, params: { id: attempt.to_param }
        expect(response).to redirect_to(login_path)
      end
    end

    describe "POST #update" do
      it "redirects to login path" do
        attempt = Attempt.create!(attributes)
        get :update, params: { id: attempt.to_param, answer_ids: [] }
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
