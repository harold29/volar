require 'rails_helper'

RSpec.describe 'payment_terms/index', type: :view do
  before(:each) do
    assign(:payment_terms, [
             PaymentTerm.create!(
               name: 'PaymentTermName',
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
             ),
             PaymentTerm.create!(
               name: 'PaymentTermName',
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
             )
           ])
  end

  it 'renders a list of payment_terms' do
    render
    assert_select 'p>strong', text: 'Name:'.to_s
    assert_select 'p>strong', text: 'Description:'.to_s
    assert_select 'p>strong', text: 'Payment type:'.to_s
    assert_select 'p>strong', text: 'Payment terms:'.to_s
    assert_select 'p>strong', text: 'Payment terms description:'.to_s
    assert_select 'p>strong', text: 'Payment terms conditions:'.to_s
    assert_select 'p>strong', text: 'Payment terms conditions url:'.to_s
    assert_select 'p>strong', text: 'Payment terms file:'.to_s
    assert_select 'p>strong', text: 'Payment terms file url:'.to_s
    # assert_select 'p>strong', text: 2.to_s, count: 2
    # assert_select 'p>strong', text: 3.to_s, count: 2
    # assert_select 'p>strong', text: 4.to_s, count: 2
    # assert_select 'p>strong', text: '9.99'.to_s, count: 2
    # assert_select 'p>strong', text: '9.99'.to_s, count: 2
    # assert_select 'p>strong', text: 5.to_s, count: 2
    # assert_select 'p>strong', text: 6.to_s, count: 2
    # assert_select 'p>strong', text: false.to_s, count: 2
    # assert_select 'p>strong', text: false.to_s, count: 2
  end
end
