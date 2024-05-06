require 'rails_helper'

RSpec.describe 'payment_terms/edit', type: :view do
  before(:each) do
    @payment_term = assign(:payment_term, PaymentTerm.create!(
                                            name: 'MyString',
                                            description: 'MyText',
                                            payment_type: 1,
                                            payment_terms: 'MyString',
                                            payment_terms_description: 'MyText',
                                            payment_terms_conditions: 'MyString',
                                            payment_terms_conditions_url: 'MyString',
                                            payment_terms_file: 'MyString',
                                            payment_terms_file_url: 'MyString',
                                            days_max_number: 1,
                                            days_min_number: 1,
                                            payment_period_in_days: 1,
                                            interest_rate: '9.99',
                                            penalty_rate: '9.99',
                                            installments_max_number: 1,
                                            installments_min_number: 1,
                                            installments: false,
                                            active: false,
                                            deleted: false
                                          ))
  end

  it 'renders the edit payment_term form' do
    render

    assert_select 'form[action=?][method=?]', payment_term_path(@payment_term), 'post' do
      assert_select 'input[name=?]', 'payment_term[name]'

      assert_select 'textarea[name=?]', 'payment_term[description]'

      assert_select 'input[name=?]', 'payment_term[payment_terms]'

      assert_select 'textarea[name=?]', 'payment_term[payment_terms_description]'

      assert_select 'input[name=?]', 'payment_term[payment_terms_conditions]'

      assert_select 'input[name=?]', 'payment_term[payment_terms_conditions_url]'

      assert_select 'input[name=?]', 'payment_term[payment_terms_file]'

      assert_select 'input[name=?]', 'payment_term[payment_terms_file_url]'

      assert_select 'input[name=?]', 'payment_term[days_max_number]'

      assert_select 'input[name=?]', 'payment_term[days_min_number]'

      assert_select 'input[name=?]', 'payment_term[payment_period_in_days]'

      assert_select 'input[name=?]', 'payment_term[interest_rate]'

      assert_select 'input[name=?]', 'payment_term[penalty_rate]'

      assert_select 'input[name=?]', 'payment_term[installments_max_number]'

      assert_select 'input[name=?]', 'payment_term[installments_min_number]'

      assert_select 'input[name=?]', 'payment_term[active]'

      assert_select 'input[name=?]', 'payment_term[deleted]'
    end
  end
end
