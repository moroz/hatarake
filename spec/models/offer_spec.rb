require 'rails_helper'

RSpec.describe Offer, type: :model do
  let(:offer) { FactoryGirl.build(:offer) }
  describe "validations" do
    context "with valid attributes" do
      it "is valid" do
        expect(offer).to be_valid
      end
    end

    describe "currency" do
      context "without currency" do
        it "is invalid" do
          offer.currency = nil
          expect(offer).not_to be_valid
        end
      end

      # Currency should be an ISO 4217-compliant
      # three-letter code
      context "with invalid currency" do
        it "is invalid" do
          offer.currency = "zł"
          expect(offer).not_to be_valid
        end
      end
    end

    context "without title" do
      it "is invalid" do
        offer.title = nil
        expect(offer).not_to be_valid
      end
    end

    context "without company" do
      it "is invalid" do
        offer.company = nil
        expect(offer).not_to be_valid
      end
    end
  end

  describe "publishing" do
    context "when created" do
      let(:offer) { FactoryGirl.create(:offer) }
      
      it "published is false" do
        expect(offer).not_to be_published
      end

      it "published_at is nil" do
        expect(offer.published_at).to be_nil
      end
    end

    describe "#publish" do
      before do
        offer.publish
      end
      
      it "published is true" do
        expect(offer).to be_published
      end

      it "published_at is set" do
        expect(offer.published_at).not_to be_nil
      end
    end
  end

  describe "scopes" do
    describe "featured"

    describe "with_country_id" do

    end

    describe "with_province_id" do

    end

    describe "offers in Poland and abroad" do
      let!(:offer_pl) { FactoryGirl.create(:offer, :published, :poland) }
      let!(:offer_de) { FactoryGirl.create(:offer, :published, :germany) }

      describe "poland" do
        subject { Offer.poland.to_a }

        it { is_expected.to include offer_pl }
        it { is_expected.not_to include offer_de }
      end

      describe "abroad" do
        subject { Offer.abroad.to_a }

        it { is_expected.to include offer_de }
        it { is_expected.not_to include offer_pl }
      end

    end
  end
end
