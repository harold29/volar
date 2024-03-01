require 'rails_helper'

RSpec.describe "airlines/new", type: :view do
  before(:each) do
    assign(:airline, Airline.new(
      name: "MyString",
      logo: "MyString"
    ))
  end

  it "renders new airline form" do
    render

    assert_select "form[action=?][method=?]", airlines_path, "post" do

      assert_select "input[name=?]", "airline[name]"

      assert_select "input[name=?]", "airline[logo]"
    end
  end
end
