FactoryGirl.define do
  factory :order do
    cart { create :cart, :with_items }
    payment_status "new"
    paid_at nil
    currency "pln"

    trait :paid do
      paid_at 2.days.ago
    end
  end
end
