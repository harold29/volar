require 'rails_helper'

RSpec.describe "airlines/edit", type: :view do
  before(:each) do
    @airline = assign(:airline, Airline.create!(
      name: "MyString",
      logo: "MyString"
    ))
  end

  it "renders the edit airline form" do
    render

    assert_select "form[action=?][method=?]", airline_path(@airline), "post" do

      assert_select "input[name=?]", "airline[name]"

      assert_select "input[name=?]", "airline[logo]"
    end
  end
end
