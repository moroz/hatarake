require 'rails_helper'

RSpec.describe 'Candidate offer application' do
  let(:candidate) { FactoryBot.create(:candidate) }
  let!(:offer) { FactoryBot.create(:offer, :published, :one_location) }

  describe 'applying for offer through application form' do
    before do
      login_as(candidate, scope: :candidate)
      visit jobs_abroad_path
    end

    it "creates an Application" do
      expect(page).to have_selector(dom_id(offer))
      click_link offer.title
      expect(current_path).to eq(offer_path(offer))
      click_link_or_button I18n.t('offers.apply_now'), match: :first
      expect(current_path).to eq(new_offer_application_path(offer_id: offer))
      find('#application_memo').set('Zażółć gęślą jaźń')
      expect { submit_form }.to change { Application.count }

      expect(ActionMailer::Base.deliveries).not_to be_empty
    end
  end

  context "when Candidate has no CandidateProfile" do
    let(:no_profile_candidate) { FactoryBot.create(:candidate, :only_login_credentials) }

    before do
      login_as(no_profile_candidate, scope: :candidate)
      visit new_offer_application_path(offer)
    end

    it "redirects to edit_candidate_profile_path" do
      expect(current_path).to eq(edit_candidate_profile_path)
    end

    it "displays an alert callout" do
      expect(page).to have_selector('.alert')
    end
  end
end
