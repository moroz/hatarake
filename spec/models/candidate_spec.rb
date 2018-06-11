require 'rails_helper'

RSpec.describe Candidate, type: :model do
  describe "scopes" do
    let!(:candidate) { FactoryBot.create(:candidate, :looking_for_work) }
    let!(:not_looking_candidate) { FactoryBot.create(:candidate, :not_looking_for_work) }
    describe "looking_for_work" do
      subject { Candidate.looking_for_work }

      it { is_expected.to include candidate }
      it { is_expected.not_to include not_looking_candidate }
    end

    describe "with_profession" do
      let!(:carpenter) { FactoryBot.create(:candidate, profession_name: "Carpenter") }
      let!(:welder) { FactoryBot.create(:candidate, profession_name: "Welder") }

      context "when given profession name" do
        subject { Candidate.with_profession "Carpenter" }

        it { is_expected.to include carpenter }
        it { is_expected.not_to include welder }
      end
    end

    describe "search" do
      let!(:smith) { FactoryBot.create(:candidate, profile: FactoryBot.create(:candidate_profile, first_name: "John", last_name: "Smith")) }
      let!(:kowalski) { FactoryBot.create(:candidate, profile: FactoryBot.create(:candidate_profile, first_name: "Jan", last_name: "Kowalski")) }

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

  describe "#should_confirm_lfw?" do
    context 'when profile is not updated after registration' do
      it 'returns false' do
        only_name_candidate = FactoryBot.build(:candidate, :only_login_credentials)
        only_name_candidate.save(validation: false)
        expect(only_name_candidate.should_confirm_lfw?).to be false
      end
    end

    context 'when profile is present' do
      def create_candidate(looking_for_work, lfw_at)
        profile = FactoryBot.create(:candidate_profile, looking_for_work: looking_for_work, lfw_at: lfw_at)
        FactoryBot.create(:candidate, profile: profile)
      end

      context 'when candidate is looking for work' do
        context 'when lfw_at is blank' do
          it 'returns true' do
            candidate = create_candidate(true, nil)
            expect(candidate.should_confirm_lfw?).to be true
          end
        end

        context 'when lfw_at is < 2 days ago' do
          it 'returns true' do
            candidate = create_candidate(true, 1.week.ago)
            expect(candidate.should_confirm_lfw?).to be true
          end
        end

        context 'when lfw_at is > 2 days ago' do
          it 'returns false' do
            candidate = create_candidate(true, 1.hour.ago)
            expect(candidate.should_confirm_lfw?).to be false
          end
        end
      end

      context 'when candidate is not looking for work' do
        context 'when lfw_at is blank' do
          it 'returns true' do
            candidate = create_candidate(false, nil)
            expect(candidate.should_confirm_lfw?).to be true
          end
        end

        context 'when lfw_at is < 2 days ago' do
          it 'returns true' do
            candidate = create_candidate(false, 1.week.ago)
            expect(candidate.should_confirm_lfw?).to be true
          end
        end

        context 'when lfw_at is > 2 days ago' do
          it 'returns false' do
            candidate = create_candidate(false, 1.hour.ago)
            expect(candidate.should_confirm_lfw?).to be false
          end
        end
      end
    end
  end

  describe "#not_updated_profile?" do
    context "when candidated just registred" do
      it "returns true" do
        candidate = FactoryBot.build(:candidate, :only_login_credentials)
        candidate.save(validate: false)
        expect(candidate.not_updated_profile?).to be true
      end
    end

    context "candidate with full credentials" do
      let (:candidate) { FactoryBot.create(:candidate) }

      it "returns false" do
        expect(candidate.not_updated_profile?).to be false
      end
    end
  end
end
