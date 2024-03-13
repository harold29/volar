require 'rails_helper'

RSpec.describe 'carriers/show', type: :view do
  before(:each) do
    @carrier = assign(:carrier, Carrier.create!(
                                  name: 'Name',
                                  logo: 'Logo',
                                  code: 'Code'
                                ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Logo/)
    expect(rendered).to match(/Code/)
  end
end
