require "rails_helper"

RSpec.describe Admin::QuestionsController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(get: "/admin/tests/1/questions/new").to route_to(
        "admin/questions#new", test_id: "1"
      )
    end

    it "routes to #show" do
      expect(get: "/admin/questions/1").to route_to(
        "admin/questions#show", id: "1"
      )
    end

    it "routes to #edit" do
      expect(get: "/admin/questions/1/edit").to route_to(
        "admin/questions#edit", id: "1"
      )
    end

    it "routes to #create" do
      expect(post: "/admin/tests/1/questions").to route_to(
        "admin/questions#create", test_id: "1"
      )
    end

    it "routes to #update via PUT" do
      expect(put: "/admin/questions/1").to route_to(
        "admin/questions#update", id: "1"
      )
    end

    it "routes to #update via PATCH" do
      expect(patch: "/admin/questions/1").to route_to(
        "admin/questions#update", id: "1"
      )
    end

    it "routes to #destroy" do
      expect(delete: "/admin/questions/1").to route_to(
        "admin/questions#destroy", id: "1"
      )
    end
  end
end
