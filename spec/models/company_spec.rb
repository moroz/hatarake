require 'rails_helper'

RSpec.describe Company do
  let(:company) { FactoryGirl.build(:company) }

  describe "validations" do
    describe "website URL format" do
      context "with invalid URL" do
        it "is invalid" do
          company.website = "dupa example ###"
          expect(company).not_to be_valid
        end
      end

      context "without website" do
        it "is valid" do
          company.website = ""
          expect(company).to be_valid
        end
      end

      context "with valid URL" do
        it "is valid" do
          company.website = "http://www.injobs.pl"
          expect(company).to be_valid
        end
      end
    end
  end

  describe "scopes" do
    let!(:company) { FactoryGirl.create(:company) }
    let!(:premium_company) { FactoryGirl.create(:company, :premium) }
    
    describe "#premium_users" do
      subject { Company.premium_users }

      it { is_expected.to include(premium_company) }
      it { is_expected.not_to include(company) }
    end
  end
end
