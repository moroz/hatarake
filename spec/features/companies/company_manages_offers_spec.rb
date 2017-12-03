require 'rails_helper'

RSpec.describe 'Company manages offers' do
  let(:company) { FactoryBot.create(:company) }
  let!(:offers) { FactoryBot.create_list(:offer, 4, company: company) }
  
  before do
    login_as(company, scope: :company)
    visit my_offers_path
  end

  describe "displaying offer dashboard" do
    it "displays list of offers" do
      expect(page).to have_selector('.offer-tr', count: 4)
    end

    it 'displays dropdown of bulk actions' do
      expect(page).to have_selector('select#update_action')
    end
  end
end
