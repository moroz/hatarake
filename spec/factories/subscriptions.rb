FactoryGirl.define do
  factory :subscription do
    company
    valid_thru { 2.weeks.from_now }
  end
end
