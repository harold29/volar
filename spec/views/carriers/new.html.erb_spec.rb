require 'rails_helper'

RSpec.describe "carriers/new", type: :view do
  before(:each) do
    assign(:carrier, Carrier.new(
      name: "MyString",
      logo: "MyString"
    ))
  end

  it "renders new carrier form" do
    render

    assert_select "form[action=?][method=?]", carriers_path, "post" do

      assert_select "input[name=?]", "carrier[name]"

      assert_select "input[name=?]", "carrier[logo]"
    end
  end
end
