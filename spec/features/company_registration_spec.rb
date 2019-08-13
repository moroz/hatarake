# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Company registration' do
  it 'registers a Company account' do
    visit '/companies/sign_up'

    page.find('#company_email').set('foobar@example.com')
    page.find('#company_password').set('foobar')
    page.find('#company_password_confirmation').set('foobar')
    page.find('#company_name').set('Foobar Inc.')

    expect { submit_form }.to change(Company, :count)
  end
end
