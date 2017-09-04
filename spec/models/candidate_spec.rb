require 'rails_helper'

RSpec.describe Candidate, type: :model do
  describe "scopes" do
    let!(:candidate) { FactoryGirl.create(:candidate, :looking_for_work) }
    let!(:not_looking_candidate) { FactoryGirl.create(:candidate, :not_looking_for_work) }
    describe "looking_for_work" do
      subject { Candidate.looking_for_work }

      it { is_expected.to include candidate }
      it { is_expected.not_to include not_looking_candidate }
    end

    describe "with_profession" do
      let!(:carpenter) { FactoryGirl.create(:candidate, profession_name: "Carpenter") }
      let!(:welder) { FactoryGirl.create(:candidate, profession_name: "Welder") }

      context "when given profession name" do
        subject { Candidate.with_profession "Carpenter" }

        it { is_expected.to include carpenter }
        it { is_expected.not_to include welder }
      end

      context "when given Profession object" do
        let(:profession) { Profession.find_or_create_by_name("Carpenter") }

        subject { Candidate.with_profession profession }

        it { is_expected.to include carpenter }
      end
    end

    describe "search" do
      let!(:smith) { FactoryGirl.create(:candidate, profile: FactoryGirl.create(:candidate_profile, first_name: "John", last_name: "Smith")) }
      let!(:kowalski) { FactoryGirl.create(:candidate, profile: FactoryGirl.create(:candidate_profile, first_name: "Jan", last_name: "Kowalski")) }

      context "by first name" do
        subject { Candidate.search("john") }

        it { is_expected.to include smith }
        it { is_expected.not_to include kowalski }
      end

      context "by last name" do
        subject { Candidate.search("smith") }
        
        it { is_expected.to include smith }
        it { is_expected.not_to include kowalski }
      end

      context "by substring of full name" do
        subject { Candidate.search("n kowa") }
        
        it { is_expected.to include kowalski }
        it { is_expected.not_to include smith }
      end
    end
  end

end
