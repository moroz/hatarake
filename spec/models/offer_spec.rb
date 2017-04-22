require 'rails_helper'

RSpec.describe Offer, type: :model do
  let(:offer) { FactoryGirl.build(:offer) }
  describe "validations" do
    context "with valid attributes" do
      it "is valid" do
        expect(offer).to be_valid
      end
    end

    context "without currency" do
      it "is invalid" do
        offer.currency = nil
        expect(offer).not_to be_valid
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
    context "when min and max present" do
      it "returns a range"
    end
    
    context "when only min present" do
      it "returns min+"
    end

    context "when only max present" do
      it "returns up to max"
    end

    context "when none present" do
      it "returns a placeholder string"
    end
  end
end
