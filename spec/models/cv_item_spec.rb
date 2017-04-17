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

  describe "before validation callbacks" do
    describe "make_dates" do
      context "when given start month and year" do
        it "converts them to Date" do
          start_date_item = FactoryGirl.build(:cv_item, :no_dates)
          start_date_item.start_month = "9"
          start_date_item.start_year = "2000"
          start_date_item.validate
          expect(start_date_item.start_date).to eq(Date.new(2000,9))
        end
      end

      context "when given end month and year" do
        it "converts them to Date" do
          end_date_item = FactoryGirl.build(:cv_item, :no_dates)
          end_date_item.end_month = "9"
          end_date_item.end_year = "2000"
          end_date_item.validate
          expect(end_date_item.end_date).to eq(Date.new(2000,9))
        end
      end
    end

    describe "swap_dates" do
      context "when end date is before start date" do
        it "swaps them" do
          cv_item.start_date = 2.years.ago
          cv_item.end_date = 3.years.ago
          cv_item.validate
          expect(cv_item.end_date).to be < cv_item.start_date
        end
      end
    end
  end

  describe "scopes" do
    let!(:edu_item) { FactoryGirl.create(:cv_item, category: "ba") }
    let!(:work_item) { FactoryGirl.create(:cv_item, :work) }

    describe "education_items" do
      it "does include educational items" do
        expect(CvItem.education_items).to include edu_item
      end

      it "does not include work items" do
        expect(CvItem.education_items).not_to include work_item
      end
    end

    describe "work_items" do
      it "does include work items" do
        expect(CvItem.work_items).to include work_item
      end

      it "does not include educational items" do
        expect(CvItem.work_items).not_to include edu_item
      end
    end
  end
end
