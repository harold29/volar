require 'rails_helper'

RSpec.describe 'payment_terms/show', type: :view do
  before(:each) do
    @payment_term = assign(:payment_term, PaymentTerm.create!(
                                            name: 'Name',
                                            description: 'MyText',
                                            payment_type: 1,
                                            payment_terms: 'Payment Terms',
                                            payment_terms_description: 'MyText',
                                            payment_terms_conditions: 'Payment Terms Conditions',
                                            payment_terms_conditions_url: 'Payment Terms Conditions Url',
                                            payment_terms_file: 'Payment Terms File',
                                            payment_terms_file_url: 'Payment Terms File Url',
                                            days_max_number: 2,
                                            days_min_number: 3,
                                            payment_period_in_days: 4,
                                            interest_rate: '9.99',
                                            penalty_rate: '9.99',
                                            installments_max_number: 5,
                                            installments_min_number: 6,
                                            installments: false,
                                            active: false,
                                            deleted: false
                                          ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Payment Terms/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Payment Terms Conditions/)
    expect(rendered).to match(/Payment Terms Conditions Url/)
    expect(rendered).to match(/Payment Terms File/)
    expect(rendered).to match(/Payment Terms File Url/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
