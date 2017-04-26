require 'rails_helper'

RSpec.describe "Candidate registration" do
  fixtures :pages

  it "registers a candidate account" do
    visit '/candidates/sign_up'

    page.find("#candidate_email").set('foobar@example.com')
    page.find("#candidate_password").set('foobar')
    page.find("#candidate_password_confirmation").set('foobar')

    expect { click_button }.to change { Candidate.count }
  end

  describe "second step" do
    let(:candidate) { FactoryGirl.create(:candidate, :only_login_credentials) }

    context "upon first login" do
      before do
        login_as(candidate, scope: :user)
        visit profile_path
      end

      it "displays form for entering personal data" do
        expect(current_path).to eq(candidate_step2_path)
      end
    end
  end
end
