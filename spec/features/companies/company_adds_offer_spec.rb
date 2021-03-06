# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Company adds Offer' do
  let(:company) { Company.first || FactoryBot.create(:company) }
  let!(:country) { FactoryBot.create(:country) }

  describe 'offer creation' do
    subject { page.body }

    before do
      login_as(company, scope: :company)
      visit root_path
    end

    it { is_expected.to have_content I18n.t('nav.add_offer') }

    it 'creates a new offer with correct attributes' do
      FactoryBot.create(:country, :poland)
      click_link I18n.t('nav.add_offer'), match: :first
      expect(page).to have_current_path(new_offer_path)

      page.find('#offer_title').set('Looking for welders')
      page.find('#offer_currency').set('EUR')
      page.find('#offer_salary_min').set(1000)
      page.find('#offer_salary_max').set(2000)
      page.find('#offer_contact_email').set('foobar@example.com')
      page.find('#location_country_id').set(country.name_en)
      page.find('#offer_contact_phone').set('555 100-888')
      page.find('#location_city').set('Berlin')
      page.find('#wmd-input').set("We're looking for welders!")

      expect { submit_form }.to change(Offer, :count)
    end
  end

  describe 'offer publishing' do
    let(:offer) { FactoryBot.create(:offer, :unpublished, company: company) }

    before do
      login_as(company, scope: :company)
      visit offer_path(offer)
    end

    xit "shows 'Publish' button" do
      expect(page.body).to have_selector(:link_or_button, I18n.t('actions.publish'))
    end

    xit 'publishes when clicked' do
      click_link_or_button I18n.t('actions.publish'), match: :first
      expect(offer.reload).to be_published
    end
  end
end
