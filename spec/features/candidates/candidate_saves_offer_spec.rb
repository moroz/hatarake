require 'rails_helper'

RSpec.describe "Candidate saves offer" do
  let(:candidate) { FactoryGirl.create(:candidate) }
  let!(:offer) { FactoryGirl.create(:offer, :published) }

  describe "in offers#index" do 
    context "when not signed in" do
      before(:each) do 
        visit offers_path
      end

      it "does show offer" do
        expect(page).to have_selector(dom_id(offer))
      end

      it "does not show 'Save offer' option" do
        within(dom_id(offer)) do
          expect(page).not_to have_content(I18n.t('offers.save_offer'))
        end
      end
    end

    context "when signed in as Candidate" do
      before(:each) do 
        login_as(candidate, scope: :candidate)
        visit offers_path
      end

      it "does show offer" do
        expect(page).to have_selector(dom_id(offer))
      end

      it "does show 'Save offer' option" do
        within(dom_id(offer)) do
          expect(page).to have_content(I18n.t('offers.save_offer'))
        end
      end
    end
  end

  describe "in offers#show" do
    context "when not signed in" do
      before(:each) do 
        visit offer_path(offer)
      end

      it "does not show 'Save offer' option" do
        expect(page).not_to have_content(I18n.t('offers.save_offer'))
      end
    end

    context "when signed in as Candidate" do
      before(:each) do 
        login_as(candidate, scope: :candidate)
        visit offer_path(offer)
      end

      it "does show 'Save offer'" do
        expect(page).to have_content(I18n.t('offers.save_offer'))
      end
    end
  end
end
