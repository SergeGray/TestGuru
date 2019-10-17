require "rails_helper"

RSpec.describe TestsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/tests").to route_to("tests#index")
    end

    it "routes to #start" do
      expect(post: "/tests/1/start/").to route_to("tests#start", id: "1")
    end
  end
end
