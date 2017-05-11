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
end
