FactoryGirl.define do
  factory :company do
    name { Faker::Company.name }
    email { Faker::Internet.email }
    password "foobar2000"
    website { Faker::Internet.url }
    confirmed_at Time.now
    premium_services nil

    trait :premium do
      premium_until 2.weeks.from_now
    end
  end
end
