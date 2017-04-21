require 'rails_helper'

RSpec.shared_examples "cv item" do
  def factory_key
    described_class.model_name.singular
  end

  let(:item) { FactoryGirl.build(factory_key) }

  describe "validations" do
    context "with valid attributes" do
      it "is valid" do
        expect(item).to be_valid
      end
    end

    context "with no dates" do
      it "is invalid" do
        no_date_item = FactoryGirl.build(factory_key, :no_dates)
        expect(no_date_item).not_to be_valid
      end
    end
  end

  describe "before validation callbacks" do
    describe "make_dates" do
      context "when given start month and year" do
        it "converts them to Date" do
          start_date_item = FactoryGirl.build(factory_key, :no_dates)
          start_date_item.start_month = "9"
          start_date_item.start_year = "2000"
          start_date_item.validate
          expect(start_date_item.start_date).to eq(Date.new(2000,9))
        end
      end

      context "when given end month and year" do
        it "converts them to Date" do
          end_date_item = FactoryGirl.build(factory_key, :no_dates)
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
          item.start_date = 2.years.ago
          item.end_date = 3.years.ago
          item.validate
          expect(item.end_date).to be < item.start_date
        end
      end
    end
  end
end

RSpec.describe EducationItem do
  include_examples "cv item"
end

RSpec.describe WorkItem do
  include_examples "cv item"
end
