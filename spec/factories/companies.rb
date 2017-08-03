FactoryGirl.define do
  factory :company do
    name { Faker::Company.name }
    email { Faker::Internet.email }
    password "foobar2000"
    website { Faker::Internet.url }
    confirmed_at Time.now
    premium_services nil

    trait :premium do

    end
  end
end
