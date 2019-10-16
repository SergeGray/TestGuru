require "rails_helper"

RSpec.describe Admin::AnswersController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(get: "/admin/questions/1/answers/new").to route_to(
        "admin/answers#new", question_id: "1"
      )
    end

    it "routes to #show" do
      expect(get: "/admin/answers/1").to route_to(
        "admin/answers#show", id: "1"
      )
    end

    it "routes to #edit" do
      expect(get: "/admin/answers/1/edit").to route_to(
        "admin/answers#edit", id: "1"
      )
    end

    it "routes to #create" do
      expect(post: "/admin/questions/1/answers").to route_to(
        "admin/answers#create", question_id: "1"
      )
    end

    it "routes to #update via PUT" do
      expect(put: "/admin/answers/1").to route_to(
        "admin/answers#update", id: "1"
      )
    end

    it "routes to #update via PATCH" do
      expect(patch: "/admin/answers/1").to route_to(
        "admin/answers#update", id: "1"
      )
    end

    it "routes to #destroy" do
      expect(delete: "/admin/answers/1").to route_to(
        "admin/answers#destroy", id: "1"
      )
    end
  end
end
