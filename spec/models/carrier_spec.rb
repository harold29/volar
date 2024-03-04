require 'rails_helper'

RSpec.describe Carrier, type: :model do
  it "is valid with a name and logo" do
    carrier = Carrier.new(
      name: "Name",
      logo: "Logo"
    )
    expect(carrier).to be_valid
  end

  it "is invalid without a name" do
    carrier = Carrier.new(name: nil)
    carrier.valid?
    expect(carrier.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a logo" do
    carrier = Carrier.new(logo: nil)
    carrier.valid?
    expect(carrier.errors[:logo]).to include("can't be blank")
  end
end
