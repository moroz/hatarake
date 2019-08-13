# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Offer search' do
  describe 'when visiting offers_path without params' do
    subject { page.body }

    before do
      visit jobs_abroad_path
    end

    it 'shows advanced search form' do
      expect(page).to have_selector('.abroad_search form')
    end

    # country select
    it { is_expected.to have_selector('.abroad_search select[name="cid"]') }
    # province select
    it { is_expected.to have_selector('.abroad_search select[name="pid"]') }
    # query search
    it { is_expected.to have_selector('.abroad_search input[name="q"]') }
  end

  describe 'searching by name' do
    let!(:matching) { FactoryBot.create(:offer, :published, :germany, title: 'Manga reader') }
    let!(:other) { FactoryBot.create(:offer, :published, :germany, title: 'Computer programmer') }

    before do
      visit jobs_abroad_path
      within('.abroad_search') do
        find('input[name="q"]').set('manga')
        click_button
      end
    end

    it 'shows matching items' do
      expect(page).to have_selector(dom_id(matching))
    end

    it 'does not show other items' do
      expect(page).not_to have_selector(dom_id(other))
    end
  end

  describe 'searching by country' do
    let!(:germany) { FactoryBot.create(:offer, :published, :germany, title: 'Offer in Germany') }
    let!(:russia) { FactoryBot.create(:offer, :published, :russia, title: 'Offer in Russia') }

    before do
      visit jobs_abroad_path(lang: 'en')
      within('.abroad_search') do
        select('Germany', from: 'cid')
        click_button
      end
    end

    it 'shows offer in Germany' do
      expect(page).to have_selector(dom_id(germany))
    end

    it 'does not show offer in Russia' do
      expect(page).not_to have_selector(dom_id(russia))
    end
  end
end
