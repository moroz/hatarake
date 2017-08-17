require 'rails_helper'

RSpec.describe "Offer search" do
  describe "when visiting offers_path without params" do
    before do
      visit jobs_abroad_path
    end

    it "shows advanced search form" do
      expect(page).to have_selector('.abroad_search form')
    end

    subject { page.body }

    # country select
    it { is_expected.to have_selector('.abroad_search select[name="cid"]') }
    # province select
    it { is_expected.to have_selector('.abroad_search select[name="pid"]') }
    # query search
    it { is_expected.to have_selector('.abroad_search input[name="q"]') }
  end

  describe "searching by name" do
    let!(:matching) { FactoryGirl.create(:offer, :published, title: "Manga reader") }
    let!(:other) { FactoryGirl.create(:offer, :published, title: "Computer programmer") }

    before(:each) do
      visit jobs_abroad_path
      within('.abroad_search') do
        find('input[name="q"]').set("manga")
        click_button
      end
    end

    it "shows matching items" do
      expect(page).to have_selector(dom_id(matching))
    end

    it "does not show other items" do
      expect(page).not_to have_selector(dom_id(other))
    end
  end

  describe "searching by country" do
    let!(:germany) { FactoryGirl.create(:offer, :published, :germany, title: "Offer in Germany") }
    let!(:russia) { FactoryGirl.create(:offer, :published, :russia, title: "Offer in Russia") }

    before(:each) do
      visit jobs_abroad_path(lang: 'en')
      within('.abroad_search') do
        select("Germany", from: 'cid')
        click_button
      end
    end

    it "shows offer in Germany" do
      expect(page).to have_selector(dom_id(germany))
    end

    it "does not show offer in Russia" do
      expect(page).not_to have_selector(dom_id(russia))
    end
  end
end
