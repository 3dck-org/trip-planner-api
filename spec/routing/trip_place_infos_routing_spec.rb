require "rails_helper"

RSpec.describe TripPlaceInfosController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/trip_place_infos").to route_to("trip_place_infos#index")
    end

    it "routes to #show" do
      expect(get: "/trip_place_infos/1").to route_to("trip_place_infos#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/trip_place_infos").to route_to("trip_place_infos#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/trip_place_infos/1").to route_to("trip_place_infos#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/trip_place_infos/1").to route_to("trip_place_infos#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/trip_place_infos/1").to route_to("trip_place_infos#destroy", id: "1")
    end
  end
end
