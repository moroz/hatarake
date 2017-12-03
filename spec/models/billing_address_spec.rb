require 'rails_helper'

RSpec.describe BillingAddress, type: :model do
  xdescribe "validations" do
    let(:address) { FactoryBot.build(:billing_address) }

    # NIP is the taxpayer ID number in the Republic of Poland
    describe "NIP number validation" do
      context "with valid NIP" do
        it "is valid" do
          address.nip = "725-18-01-126"
          expect(address).to be_valid
        end
      end

      context "with NIP = nil" do
        it "is invalid" do
          address.nip = nil
          expect(address).not_to be_valid
        end
      end

      context "with NIP = ''" do
        it "is invalid" do
          address.nip = ''
          expect(address).not_to be_valid
        end
      end

      context "with incorrect NIP number" do
        it "is invalid" do
          address.nip = '123-45-67-890'
          expect(address).not_to be_valid
        end
      end
    end
  end
end
