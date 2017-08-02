FactoryGirl.define do
  factory :order do
    cart
    payment_status "new"
    paid_at nil
    currency "pln"
  end
end
