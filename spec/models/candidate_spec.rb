require 'rails_helper'

RSpec.describe Candidate, type: :model do
  describe "scopes" do
    let!(:candidate) { FactoryGirl.create(:candidate, looking_for_work: true) }
    let!(:not_looking_candidate) { FactoryGirl.create(:candidate, :not_looking_for_work) }
    describe "looking for work" do
      subject { Candidate.looking_for_work }

      it { is_expected.to include candidate }
      it { is_expected.not_to include not_looking_candidate }
    end

    describe "with profession" do
      context "when given profession name" do
        it "returns candidates with profession name"
      end

      context "when given Profession object" do
        it "returns candidates with profession"
      end
    end
  end

end
