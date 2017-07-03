FactoryGirl.define do
  factory :company do
    name { Faker::Company.name }
    email { Faker::Internet.email }
    password "foobar2000"
    website { Faker::Internet.url }

    trait :premium do
      after(:create) do |company, evaluator|
        create(:subscription, :paid, company: company)
      end
    end
  end
end
