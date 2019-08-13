# frozen_string_literal: true

require 'rails_helper'

def select_homepage_and_submit
  select(I18n.t('offers.promote.methods.homepage'), from: :method)
  submit_form
end

RSpec.describe 'Company promotes offers' do
  let(:company) { FactoryBot.create(:company, premium_services: { 2 => 10, 3 => 10, 4 => 10 }) }
  let!(:offer) { FactoryBot.create(:offer, :published, company: company) }

  before do
    login_as(company, scope: :company)
    visit promote_offer_path(offer)
  end

  context 'when offer is not promoted' do
    it 'promotes the offer' do
      select_homepage_and_submit

      expect(page).to have_current_path(my_offers_path)
      expect(offer.reload).to be_homepage_featured
    end
  end

  context 'when offer is already promoted' do
    let!(:offer) { FactoryBot.create(:offer, :published, company: company, featured_until: 2.weeks.from_now) }

    it 'redirects back and displays error message' do
      expect { select_homepage_and_submit }.not_to change(offer, :featured_until)

      expect(page).to have_current_path(promote_offer_path(offer))
      expect(page).to have_selector('.alert')
    end
  end

  context 'when company has no premium services left' do
    let(:company) { FactoryBot.create(:company, premium_services: nil) }

    FactoryBot.create(:product)
    it 'redirects to cart page' do
      expect { select_homepage_and_submit }.not_to change(offer, :featured_until)
      expect(page).to have_current_path(cart_path)
    end
  end
end
