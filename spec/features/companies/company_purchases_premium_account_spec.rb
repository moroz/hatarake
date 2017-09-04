require 'rails_helper'

RSpec.describe 'Company purchases Premium account' do
  let(:company) { FactoryGirl.create(:company) }

  before do
    login_as(company, scope: :company)
  end
end
