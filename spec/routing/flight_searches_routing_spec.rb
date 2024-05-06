require 'rails_helper'

RSpec.describe FlightOffersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/flight_offers').to route_to('flight_offers#index')
    end

    it 'routes to #new' do
      expect(get: '/flight_offers/new').to route_to('flight_offers#new')
    end

    it 'routes to #show' do
      expect(get: '/flight_offers/1').to route_to('flight_offers#show', id: '1')
    end

    # it "routes to #edit" do
    #   expect(get: "/flight_offers/1/edit").to route_to("flight_offers#edit", id: "1")
    # end

    # it "routes to #create" do
    #   expect(post: "/flight_offers").to route_to("flight_offers#create")
    # end

    # it "routes to #update via PUT" do
    #   expect(put: "/flight_offers/1").to route_to("flight_offers#update", id: "1")
    # end

    # it "routes to #update via PATCH" do
    #   expect(patch: "/flight_offers/1").to route_to("flight_offers#update", id: "1")
    # end

    # it "routes to #destroy" do
    #   expect(delete: "/flight_offers/1").to route_to("flight_offers#destroy", id: "1")
    # end
  end
end
