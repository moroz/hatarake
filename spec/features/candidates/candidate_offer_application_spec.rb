require 'rails_helper'

RSpec.describe 'Candidate offer application' do
  let(:candidate) { FactoryGirl.create(:candidate) }
  let!(:offer) { FactoryGirl.create(:offer, :published) }

  before do
    login_as(candidate, scope: :candidate)
    visit jobs_abroad_path
  end

  describe 'applying for offer through application form' do
    it "creates an Application" do
      expect(page).to have_selector(dom_id(offer))
      click_link offer.title
      expect(current_path).to eq(offer_path(offer))
      click_link_or_button I18n.t('offers.apply_now')
      expect(current_path).to eq(new_offer_application_path(offer_id: offer))
      find('#application_memo').set('Zażółć gęślą jaźń')
      expect { submit_form }.to change { Application.count }

      expect(ActionMailer::Base.deliveries).not_to be_empty
    end
  end
end
