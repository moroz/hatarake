require 'rails_helper'

RSpec.describe "Company adds Offer" do
  let(:company) { Company.first || FactoryGirl.create(:company) }

  before do
    login_as(company, scope: :user)
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
    page.find("#offer_contact_phone").set("555 100-888")
    page.find("#offer_location").set("Berlin")
    page.find("#offer_description").set("We're looking for welders!")

    expect { click_button }.to change { Offer.count }
  end
end