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

    context "when called on an unpaid order" do
      before do
        order.paid!
      end

      it "sets paid_at" do
        expect(order.paid_at).to be_within(1.second).of(Time.now)
      end

      it "changes user's premium_services hash" do
        expect(order.user.premium_services).to eq(order.to_h)
      end
    end
  end

  describe "nested attributes for BillingAddress" do
    let(:order) { FactoryGirl.build(:order, :with_billing_address_attributes) }

    context 'when invoice = true' do
      it 'saves BillingAddress' do
        order.invoice = true
        order.save
        expect(order.billing_address).to be_persisted
      end
    end

    context 'when invoice = false' do
      it 'does not save BillingAddress' do
        order.invoice = false
        order.save
        expect(order.billing_address).not_to be_persisted
      end
    end
  end
end
