require 'rails_helper'

RSpec.describe OfferSave, type: :model do
  let(:offer) { FactoryGirl.create(:offer) }
  let(:user) { FactoryGirl.create(:candidate) }
  let(:save) { OfferSave.new(offer: offer, user: user) }
  
  describe "validations" do
    describe "associations" do
      context "with offer and user" do
        it "is valid" do
          expect(save).to be_valid
        end
      end

      context "without offer" do
        it "is invalid" do
          save.offer = nil
          expect(save).not_to be_valid
        end
      end

      context "without user" do
        it "is invalid" do
          save.user = nil
          expect(save).not_to be_valid
        end
      end
    end

    describe "uniqueness" do
      it "duplicate record is invalid" do

      end
    end
  end
end
