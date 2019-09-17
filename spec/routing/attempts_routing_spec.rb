require "rails_helper"

RSpec.describe QuestionsController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(get: "/attempts/1").to route_to("attempts#show", id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "/attempts/1").to route_to("attempts#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/attempts/1").to route_to("attempts#update", id: "1")
    end

    it "routes to #result" do
      expect(get: "/attempts/1/result").to route_to("attempts#result", id: "1")
    end
  end
end
