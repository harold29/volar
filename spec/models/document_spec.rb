require 'rails_helper'

RSpec.describe Document, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:document)).to be_valid
  end

  it 'is not valid without a document_type' do
    document = build(:document, document_type: nil)
    expect(document).to_not be_valid
  end

  it 'is not valid without a document_number' do
    document = build(:document, document_number: nil)
    expect(document).to_not be_valid
  end

  it 'is not valid without an expiration_date' do
    document = build(:document, expiration_date: nil)
    expect(document).to_not be_valid
  end

  it 'is not valid without an issuance_country' do
    document = build(:document, issuance_country: nil)
    expect(document).to_not be_valid
  end

  it 'is not valid without a nationality' do
    document = build(:document, nationality: nil)
    expect(document).to_not be_valid
  end
end
