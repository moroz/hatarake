FactoryGirl.define do
  factory :subscription do
    company
    valid_until nil
    paid false
    paid_at nil

    trait :paid do
      paid true
      paid_at 2.weeks.ago
      valid_until 
    end
  end
end
