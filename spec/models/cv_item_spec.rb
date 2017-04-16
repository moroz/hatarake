require 'rails_helper'

RSpec.describe CvItem, type: :model do
  let(:cv_item) { FactoryGirl.build(:cv_item) }
  let(:work_item) { FactoryGirl.build(:cv_item, :work) }
  describe "validations" do
    context "with valid attributes" do
      it "is valid" do
        expect(cv_item).to be_valid
      end
    end

    context "with no dates" do
      it "is invalid" do
        no_date_item = FactoryGirl.build(:cv_item, :no_dates)
        expect(no_date_item).not_to be_valid
      end
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
