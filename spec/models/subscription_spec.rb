require 'rails_helper'

RSpec.describe Subscription, type: :model do
  let(:company) { FactoryGirl.create(:company) }
  let(:subscription) { Subscription.new(company: company) }

  describe "active?" do
    context "when valid_until is nil" do
      it "returns false" do
        subscription.valid_until = nil
        expect(subscription.active?).to be false
      end
    end

    context "when valid_until is in the past" do
      it "returns false" do
        subscription.valid_until = 1.day.ago
        expect(subscription.active?).to be false
      end
    end

    context 'when valid_until is in the future' do
      it 'returns true' do
        subscription.valid_until = 2.days.from_now
        expect(subscription.active?).to be true
      end
    end
  end

  describe "paid!" do
    let(:subscription) { Subscription.create(company: company, duration: 3.months) }

    context "when company has no active subscription" do
      it "sets valid_until to duration from now" do
        subscription.paid!
        expect(subscription.valid_until).to be_within(1.second).of Time.now + subscription.duration
      end
    end

    context 'when company has an active subscription' do
      let!(:active_subscription) { Subscription.create(company: company, valid_until: 2.weeks.from_now) }

      it 'sets valid_until to 1 month from active value' do
        present = active_subscription.valid_until
        subscription.paid!
        expect(subscription.valid_until).to be_within(1.second).of present + subscription.duration
      end
    end
  end
end
