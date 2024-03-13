require 'rails_helper'

RSpec.describe 'carriers/index', type: :view do
  before(:each) do
    assign(:carriers, [
             Carrier.create!(
               name: 'Name',
               logo: 'Logo',
               code: 'Code'
             ),
             Carrier.create!(
               name: 'Name',
               logo: 'Logo',
               code: 'Code'
             )
           ])
  end

  it 'renders a list of carriers' do
    render
    assert_select 'p>strong', text: 'Name:'.to_s, count: 2
    assert_select 'p>strong', text: 'Logo:'.to_s, count: 2
    assert_select 'p>strong', text: 'Code:'.to_s, count: 2
  end
end
