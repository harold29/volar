require 'rails_helper'

RSpec.describe Traveler, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:traveler)).to be_valid
  end

  it 'is not valid without a first_name' do
    traveler = build(:traveler, first_name: nil)
    expect(traveler).to_not be_valid
  end

  it 'is not valid without a last_name' do
    traveler = build(:traveler, last_name: nil)
    expect(traveler).to_not be_valid
  end

  it 'is not valid without an email' do
    traveler = build(:traveler, email: nil)
    expect(traveler).to_not be_valid
  end

  it 'is not valid without a birthdate' do
    traveler = build(:traveler, birthdate: nil)
    expect(traveler).to_not be_valid
  end

  it 'is not valid without a traveler_type' do
    traveler = build(:traveler, traveler_type: nil)
    expect(traveler).to_not be_valid
  end

  it 'is not valid without a document' do
    traveler = build(:traveler, document: nil)
    expect(traveler).to_not be_valid
  end

  it 'is not valid without a telephone' do
    traveler = build(:traveler, telephone: nil)
    expect(traveler).to_not be_valid
  end

  it 'is not valid with an invalid email' do
    traveler = build(:traveler, email: 'invalid_email')
    expect(traveler).to_not be_valid
  end

  it 'is not valid with an invalid birthdate' do
    traveler = build(:traveler, birthdate: 'invalid_date')
    expect(traveler).to_not be_valid
  end

  # it 'is not valid with an invalid document' do
  #   traveler = build(:traveler, document: 'invalid_document')
  #   expect(traveler).to_not be_valid
  # end
end
