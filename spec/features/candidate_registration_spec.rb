require 'rails_helper'

RSpec.describe "Candidate registration" do
  it "registers a candidate account" do
    visit '/candidates/sign_up'

    page.find("#candidate_email").set('foobar@example.com')
    page.find("#candidate_password").set('foobar')
    page.find("#candidate_password_confirmation").set('foobar')
    page.find("#candidate_first_name").set('Example')
    page.find("#candidate_last_name").set('User')

    expect { click_button }.to change { Candidate.count }
  end
end
