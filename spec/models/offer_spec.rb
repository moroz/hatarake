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

    context "when apply_on_website is false" do
      let(:offer) { FactoryGirl.build(:offer, apply_on_website: false) }
      context 'without application_url' do
        it 'is valid' do
          offer.application_url = nil
          expect(offer).to be_valid
        end
      end
    end

    context "when apply_on_website is true" do
      let(:offer) { FactoryGirl.build(:offer, :apply_on_website) }

      context "without application_url" do
        it "is invalid" do
          offer.application_url = nil
          expect(offer).not_to be_valid
        end
      end

      context "with invalid application_url" do
        it "is invalid" do
          offer.application_url = 'foobar'
          expect(offer).not_to be_valid
        end
      end

      context "with valid application_url" do
        it "is valid" do
          offer.application_url = 'https://www.injobs.pl'
          expect(offer).to be_valid
        end
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

    describe "featured scopes" do
      let!(:unfeatured) { FactoryGirl.create(:offer, :unfeatured) }
      let!(:homepage_featured) { FactoryGirl.create(:offer, :homepage_featured) }

      describe "#homepage_featured" do
        let!(:homepage_past) { FactoryGirl.create(:offer, featured_until: 2.weeks.ago) }

        subject { Offer.homepage_featured }
        it { is_expected.to include(homepage_featured) }
        it { is_expected.not_to include(unfeatured) }
        it { is_expected.not_to include(homepage_past) }
      end

      describe "offers featured within category" do
        let!(:category_featured) { FactoryGirl.create(:offer, :category_featured) }
        let!(:category_past) { FactoryGirl.create(:offer, category_until: 2.weeks.ago) }

        describe "#category_featured" do
          subject { Offer.category_featured }
          it { is_expected.to include(category_featured) }
          it { is_expected.not_to include(unfeatured) }
          it { is_expected.not_to include(category_past) }
        end

        describe "#not_category_featured" do
          subject { Offer.not_category_featured }
          it { is_expected.not_to include(category_featured) }
          it { is_expected.to include(unfeatured) }
          it { is_expected.to include(category_past) }
        end
      end
    end

    describe "adding premium services" do
      let(:offer) { FactoryGirl.create(:offer, :published) }

      describe "self.add_premium" do
        let!(:offers) { FactoryGirl.create_list(:offer, 3) }

      end
    end
  end
end
