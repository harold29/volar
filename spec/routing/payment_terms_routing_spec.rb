require "rails_helper"

RSpec.describe PaymentTermsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/payment_terms").to route_to("payment_terms#index")
    end

    it "routes to #show" do
      expect(get: "/payment_terms/1").to route_to("payment_terms#show", id: "1")
    end

    it "routes to #create" do
      expect(post: "/payment_terms").to route_to("payment_terms#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/payment_terms/1").to route_to("payment_terms#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/payment_terms/1").to route_to("payment_terms#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/payment_terms/1").to route_to("payment_terms#destroy", id: "1")
    end
  end
end
