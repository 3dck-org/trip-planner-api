require "rails_helper"

RSpec.describe JourneysController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/journeys").to route_to("journeys#index")
    end

    it "routes to #show" do
      expect(get: "/journeys/1").to route_to("journeys#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/journeys").to route_to("journeys#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/journeys/1").to route_to("journeys#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/journeys/1").to route_to("journeys#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/journeys/1").to route_to("journeys#destroy", id: "1")
    end
  end
end
