require 'rails_helper'

RSpec.describe Subscription, type: :model do
  let(:company) { FactoryGirl.create(:company) }
  let(:subscription) { Subscription.new(company: company) }

  describe "active?" do
    context "when valid_thru is nil" do
      it "returns false" do
        subscription.valid_thru = nil
        expect(subscription.active?).to be false
      end
    end

    context "when valid_thru is in the past" do
      it "returns false" do
        subscription.valid_thru = 1.day.ago
        expect(subscription.active?).to be false
      end
    end

    context 'when valid_thru is in the future' do
      it 'returns true' do
        subscription.valid_thru = 2.days.from_now
        expect(subscription.active?).to be true
      end
    end
  end

  describe "activate_or_prolong!" do
    let(:subscription) { Subscription.create(company: company) }
    let(:active_subscription) { Subscription.create(company: company, valid_thru: 2.weeks.from_now) }
  
    context "when called without arguments" do
      context "when Subscription is not active/expired" do
        it "sets valid_thru to 1 month from now" do
          subscription.activate_or_prolong!
          expect(subscription.valid_thru).to be_within(1.second).of 1.month.from_now
        end
      end

      context 'when subscription is active' do
        it 'sets valid_thru to 1 month from present value' do
          present = active_subscription.valid_thru
          active_subscription.activate_or_prolong!
          expect(active_subscription.valid_thru).to eq(present + 1.month)
        end
      end

    end

    context "when called with ActiveSupport::Duration" do
      context "when Subscription is not active/expired" do
        it "sets valid_thru to duration from now" do
          subscription.activate_or_prolong! 3.months
          expect(subscription.valid_thru).to be_within(1.second).of 3.months.from_now
        end
      end

      context "when subscription is active" do
        it "sets valid_thru to duration from present value" do
          present = active_subscription.valid_thru
          active_subscription.activate_or_prolong! 3.months
          expect(active_subscription.valid_thru).to eq(present + 3.months)
        end
      end
    end
  end
end
