# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { FactoryBot.create(:order) }

  describe '#paid!' do
    context 'when called on a paid order' do
      let(:paid_order) { FactoryBot.create(:order, :paid) }
      it 'raises an exception' do
        expect { paid_order.paid! }.to raise_exception RuntimeError
      end
    end

    context 'when called on an unpaid order' do
      before do
        order.paid!
      end

      it 'sets paid_at' do
        expect(order.paid_at).to be_within(1.second).of(Time.now)
      end

      it "changes user's premium_services hash" do
        expect(order.user.premium_services).to eq(order.to_h)
      end
    end
  end

  describe 'upon creation' do
    let(:order) { FactoryBot.build(:order) }
    context 'when deduction is nil' do
      it 'amount_due == total' do
        order.save
        expect(order.amount_due).to eq(order.total)
      end
    end

    context 'when deduction is not nil' do
      it 'amount_due = total - deduction' do
        allow(order).to receive(:total).and_return(69)
        order.deduction = 27
        order.save
        expect(order.amount_due).to eq(42)
      end
    end

    context 'when deduction > total' do
      it 'amount_due = 0' do
        allow(order).to receive(:total).and_return(42)
        order.deduction = 69
        order.save
        expect(order.amount_due).to eq(0)
      end
    end
  end

  describe 'nested attributes for BillingAddress' do
    let(:order) { FactoryBot.build(:order, :with_billing_address_attributes) }

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
