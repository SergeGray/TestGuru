require "rails_helper"

RSpec.describe QuestionsController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(get: "tests/1/questions/new").to route_to(
        "questions#new", test_id: "1"
      )
    end

    it "routes to #show" do
      expect(get: "/questions/1").to route_to("questions#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/questions/1/edit").to route_to("questions#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "tests/1/questions").to route_to(
        "questions#create", test_id: "1"
      )
    end

    it "routes to #update via PUT" do
      expect(put: "/questions/1").to route_to("questions#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/questions/1").to route_to("questions#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/questions/1").to route_to("questions#destroy", id: "1")
    end
  end
end
