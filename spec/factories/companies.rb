FactoryGirl.define do
  factory :company do
    name { Faker::Company.name }
    email { Faker::Internet.email }
    password "foobar2000"
    website { Faker::Internet.url }

    trait :premium do
      after_create do |company|
        association :subscriptions, factory: :subscription
      end
    end
  end
end
