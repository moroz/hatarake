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

      context "with URL with http://" do
        before { company.website = "http://www.injobs.pl" }

        it "is valid" do
          expect(company).to be_valid
        end

        it "after validation protocol is http" do
          company.validate
          expect(URI.parse(company.website).scheme).to eq 'http'
        end
      end

      context "with URL with https://" do
        before { company.website = "https://www.injobs.pl" }
        it "is valid" do
          expect(company).to be_valid
        end

        it "after validation protocol is https" do
          company.validate
          expect(URI.parse(company.website).scheme).to eq 'https'
        end
      end

      context "with URL with no protocol" do
        before { company.website = "www.injobs.pl" }
        it "is valid" do
          expect(company).to be_valid
        end

        it "after validation protocol is http" do
          company.validate
          expect(URI.parse(company.website).scheme).to eq 'http'
        end
      end

    end
  end

  describe "#add_premium_services" do

    context "with wrong type of argument" do
      it "raises ArgumentError" do
        expect { company.add_premium_services("string") }.to raise_exception(ArgumentError)
      end
    end

    context "when user has no premium services" do
      let(:company) { FactoryGirl.create(:company, premium_services: nil) }
      
      it "sets premium_services to the hash" do
        company.add_premium_services({2 => 1, 3 => 6})

        expect(company.premium_services).to eq({'2' => '1', '3' => '6'})
      end
    end

    context "when user already has premium services" do
      let(:company) { FactoryGirl.create(:company, premium_services: {2 => 1, 3 => 6}) }

      it "sets premium_services to sum of hashes" do
        company.add_premium_services({2 => 2, 3 => 3, 4 => 1})

        expect(company.premium_services).to eq({'2' => '3', '3' => '9', '4' => '1'})
      end
    end
  end

  #describe "scopes" do
    #let!(:company) { FactoryGirl.create(:company) }
    
    #describe "#premium_users" do
      #subject { Company.premium_users }

      #it { is_expected.to include(premium_company) }
      #it { is_expected.not_to include(company) }
    #end
  #end
end
