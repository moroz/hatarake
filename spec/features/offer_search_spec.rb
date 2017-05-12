require 'rails_helper'

RSpec.describe "Offer search" do
  describe "when visiting offers_path without params" do
    before do
      visit offers_path
    end

    it "shows basic search form" do
      expect(page).to have_selector('.basic_search form')
    end

    subject { page.body }

    it { is_expected.to have_selector('.basic_search input[name="q"]') }
  end

  describe "when visiting offers_path with adv=1" do
    before do
      visit offers_path(adv: 1)
    end

    it "shows advanced search form" do
      expect(page).to have_selector('.advanced_search form')
    end

    subject { page.body }

    # country select
    it { is_expected.to have_selector('.advanced_search select[name="cid"]') }
    # province select
    it { is_expected.to have_selector('.advanced_search select[name="pid"]') }
    # currency select
    it { is_expected.to have_selector('.advanced_search select[name="cur"]') }
    # minimal salary input
    it { is_expected.to have_selector('.advanced_search input[name="smin"]') }
    # query search
    it { is_expected.to have_selector('.advanced_search input[name="smin"]') }
  end

  def dom_id(object)
    "#" + object.class.to_s.downcase + "_#{object.id}"
  end

  describe "searching by name" do
    let!(:matching) { FactoryGirl.create(:offer, :published, title: "Manga reader") }
    let!(:other) { FactoryGirl.create(:offer, :published, title: "Computer programmer") }

    before(:each) do
      visit offers_path(adv: 1)
      within('.advanced_search') do
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
      visit offers_path(adv: 1, lang: 'en')
      within('.advanced_search') do
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