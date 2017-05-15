require 'rails_helper'

RSpec.describe "Company adds Offer" do
  let(:company) { Company.first || FactoryGirl.create(:company) }
  let!(:country) { FactoryGirl.create(:country) }

  describe "offer creation" do
    before do
      login_as(company, scope: :company)
      visit offers_path
    end

    subject { page.body }
    it { is_expected.to have_content I18n.t('offers.add_new_offer') }

    it "creates a new offer with correct attributes" do
      click_link I18n.t('offers.add_new_offer')
      expect(current_path).to eq(new_offer_path)

      page.find('#offer_title').set("Looking for welders")
      page.find("#offer_currency").set("EUR")
      page.find("#offer_salary_min").set(1000)
      page.find("#offer_salary_max").set(2000)
      page.find("#offer_contact_email").set("foobar@example.com")
      page.find("#offer_country_id").set(country.name_en)
      page.find("#offer_contact_phone").set("555 100-888")
      page.find("#offer_location").set("Berlin")
      page.find("#offer_description").set("We're looking for welders!")
      
      expect { submit_form }.to change { Offer.count }
    end

  end

  describe "offer publishing" do
    let(:offer) { FactoryGirl.create(:offer, :unpublished,
                                     company: company) }
    before do
      login_as(company, scope: :company)
      visit offer_path(offer)
    end

    it "shows 'Publish' button" do
      expect(page.body).to have_selector(:link_or_button, I18n.t('actions.publish'))
    end

    it "publishes when clicked" do
      click_link_or_button I18n.t('actions.publish'), match: :first
      expect(offer.reload).to be_published
    end

  end

end
