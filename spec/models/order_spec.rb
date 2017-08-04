require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { FactoryGirl.create(:order) }

  describe "#paid!" do
    context "when called on a paid order" do
      let(:paid_order) { FactoryGirl.create(:order, :paid) }
      it "raises an exception" do
        expect { paid_order.paid! }.to raise_exception RuntimeError
      end
    end
  end
end
