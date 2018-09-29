# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Candidate confirms looking for work' do
  let(:candidate) { FactoryBot.create(:candidate, :looking_for_work) }

  before do
    login_as(candidate, scope: :candidate)
    candidate.profile.update_column(:lfw_at, 3.days.ago)
    visit profile_path
  end

  context 'when candidate is looking for work' do
    context 'when lfw_at < 2 days ago' do
      it 'shows callout to confirm lfw' do
        expect(page).to have_selector('#confirm_lfw_callout')
      end
    end

    context 'when lfw_at > 2 days ago' do
      before do
        candidate.profile.update_column(:lfw_at, 1.day.ago)
        visit profile_path
      end

      it 'does not show callout' do
        expect(page).not_to have_selector('#confirm_lfw_callout')
      end
    end
  end

  context "when candidate isn't looking for work and lfw_at < 2 days ago" do
    let(:candidate) { FactoryBot.create(:candidate, :not_looking_for_work) }

    it 'shows callout to ask' do
      expect(page).to have_selector('#confirm_lfw_callout')
    end
  end

  describe 'confirmation' do
    context 'when user clicks yes' do
      before do
        within '#confirm_lfw_callout' do
          click_link_or_button I18n.t('true')
        end
      end

      it "doesn't show the callout again" do
        expect(page).not_to have_selector('#confirm_lfw_callout')
      end

      describe 'changes in the model' do
        before do
          candidate.profile.reload
        end

        it 'changes looking_for_work to true' do
          expect(candidate.profile.looking_for_work).to be true
        end

        it 'touches lfw_at' do
          expect(candidate.profile.lfw_at).to be_within(1.second).of(Time.now)
        end
      end
    end

    context 'when user clicks yes' do
      before do
        within '#confirm_lfw_callout' do
          click_link_or_button I18n.t('false')
        end
      end

      it "doesn't show the callout again" do
        expect(page).not_to have_selector('#confirm_lfw_callout')
      end

      describe 'changes in the model' do
        before do
          candidate.profile.reload
        end

        it 'changes looking_for_work to a falsy value' do
          expect(candidate.profile.looking_for_work).to be_falsy
        end

        it 'touches lfw_at' do
          expect(candidate.profile.lfw_at).to be_within(1.second).of(Time.now)
        end
      end
    end
  end
end
