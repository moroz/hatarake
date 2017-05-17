require 'rails_helper'

RSpec.describe Company do
  describe "validations" do
    describe "website URL format" do
      context "with invalid URL" do
        it "is invalid"
      end

      context "without website" do
        it "is valid"
      end

      context "with valid URL" do
        it "is valid"
      end
    end
  end
end
