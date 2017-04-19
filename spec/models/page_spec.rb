require 'rails_helper'

RSpec.describe Page, type: :model do
  describe "Validations" do
    describe "permalink" do
      context "with unique permalink" do
        it "is valid"
      end

      context "with an existing permalink" do
        it "is invalid"
      end

      context "without permalink" do
        it "is invalid"
      end
    end
  end
end
