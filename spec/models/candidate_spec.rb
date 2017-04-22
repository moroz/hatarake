require 'rails_helper'

RSpec.describe Candidate, type: :model do
  describe "scopes" do
    describe "looking for work" do
      it "returns candidates looking for work"

      it "does not return candidates not looking for work"
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
