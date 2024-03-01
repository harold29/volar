require 'rails_helper'

RSpec.describe "airlines/index", type: :view do
  before(:each) do
    assign(:airlines, [
      Airline.create!(
        name: "Name",
        logo: "Logo"
      ),
      Airline.create!(
        name: "Name",
        logo: "Logo"
      )
    ])
  end

  it "renders a list of airlines" do
    render
    assert_select "p>strong", text: "Name:".to_s, count: 2
    assert_select "p>strong", text: "Logo:".to_s, count: 2
  end
end
