require "rails_helper"

RSpec.describe AirlinesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/airlines").to route_to("airlines#index")
    end

    it "routes to #new" do
      expect(get: "/airlines/new").to route_to("airlines#new")
    end

    it "routes to #show" do
      expect(get: "/airlines/1").to route_to("airlines#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/airlines/1/edit").to route_to("airlines#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/airlines").to route_to("airlines#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/airlines/1").to route_to("airlines#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/airlines/1").to route_to("airlines#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/airlines/1").to route_to("airlines#destroy", id: "1")
    end
  end
end
