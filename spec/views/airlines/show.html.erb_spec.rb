require 'rails_helper'

RSpec.describe "airlines/show", type: :view do
  before(:each) do
    @airline = assign(:airline, Airline.create!(
      name: "Name",
      logo: "Logo"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Logo/)
  end
end
