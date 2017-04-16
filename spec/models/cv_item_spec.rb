require 'rails_helper'

RSpec.describe CvItem, type: :model do
  let(:edu_item) { FactoryGirl.build(:cv_item) }
  let(:work_item) { FactoryGirl.build(:cv_item, :work) }
  describe "validations" do
    context "with valid attributes" do
      it "is valid"
    end

    context "with no dates" do
      it "is invalid"
    end
  end

  describe "make_dates" do
    context "when given start month and year" do
      it "converts them to Date"
    end

    context "when given end month and year" do
      it "converts them to Date"
    end

    context "when end date is before start date" do
      it "swaps them"
    end
  end

  describe "scopes" do
    describe "education_items"
    describe "work_items"
  end
end
