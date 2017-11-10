require 'rails_helper'

RSpec.describe "Candidate registration" do
  it "registers a candidate account" do
    visit sign_up_path

    find("#candidate_email").set('foobar@example.com')
    find("#candidate_password").set('foobar')
    find("#candidate_password_confirmation").set('foobar')
    
    expect { submit_form }.to change { Candidate.count }
  end

  describe "second step" do
    let(:candidate) { FactoryGirl.create(:candidate, :only_login_credentials) }
    before do
      login_as(candidate, scope: :candidate)
      visit profile_path
    end

    context "upon first login" do

      it "redirects to step2 path" do
        expect(current_path).to eq(edit_candidate_profile_path)
      end

      describe "form has all fields" do
        it "shows fields for looking_for_work" do
          expect(page).to have_selector '.candidate_profile_looking_for_work'
        end

        it "shows fields for names" do
          expect(page).to have_selector '.candidate_profile_first_name'
          expect(page).to have_selector '.candidate_profile_last_name'
        end

        it "shows field for profession name" do
          expect(page).to have_selector '.candidate_profile_profession_name'
        end
      end
    end

    describe "adding data" do
      context "submitted with correct attributes" do
        it "saves candidate's profile data" do
          within '.candidate_profile_looking_for_work' do
            choose I18n.t('true')
          end
          within '.candidate_profile_sex' do
            choose I18n.t('sexes.long.male')
          end

          find("#candidate_profile_attributes_first_name").set("John")
          find("#candidate_profile_attributes_last_name").set("Smith")
          find("#candidate_profile_attributes_profession_name").set("Fireman")

          submit_form

          u = candidate.reload
          p = u.profile

          expect(p.first_name).to eq("John")
          expect(p.last_name).to eq("Smith")
          expect(p.sex).to eq("male")
          expect(p.looking_for_work).to eq(true)
          expect(u.profession_name).to eq("Fireman")
        end
      end
    end
  end
end
