require 'rails_helper'

RSpec.shared_examples "cv item" do
  def factory_key
    described_class.model_name.singular
  end

  let(:item) { FactoryBot.build(factory_key) }

  describe "validations" do
    context "with valid attributes" do
      it "is valid" do
        expect(item).to be_valid
      end
    end

    context "with no dates" do
      it "is invalid" do
        no_date_item = FactoryBot.build(factory_key, :no_dates)
        expect(no_date_item).not_to be_valid
      end
    end
  end

  describe "before validation callbacks" do
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


