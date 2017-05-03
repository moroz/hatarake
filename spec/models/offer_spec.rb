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

  describe "salary" do
    def salary_string(offer, format)
      I18n.t('offers.salary.' + format, min: offer.salary_min,
             max: offer.salary_max, currency: offer.currency.upcase)
    end
    context "when min and max present" do
      context "when min == max" do
        it "returns one value" do
          offer.salary_min = 1000
          offer.salary_max = 1000
          expect(offer.salary).to eq salary_string(offer, 'mineqmax')
        end
      end

      context "when min != max" do
        it "returns a range" do
          offer.salary_min = 1000
          offer.salary_max = 2000
          expect(offer.salary).to eq salary_string(offer, 'minmax')
        end
      end
    end

    context "when only min present" do
      it "returns min+" do
        offer.salary_min = 1000
        offer.salary_max = nil
        expect(offer.salary).to eq salary_string(offer, 'min')
      end
    end

    context "when only max present" do
      it "returns up to max" do
        offer.salary_min = nil
        offer.salary_max = 1000
        expect(offer.salary).to eq salary_string(offer, 'max')
      end
    end

    context "when none present" do
      it "returns a placeholder string" do
        offer.salary_min, offer.salary_max = nil
        expect(offer.salary).to eq salary_string(offer, 'none')
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
end
