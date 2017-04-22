FactoryGirl.define do
  factory :candidate do
    first_name "Example"
    last_name "User"
    birth_date { 20.years.ago }
    email { Faker::Internet.email }
    password "foobar2000"
    profession_name "Carpenter"
    looking_for_work true

    trait :no_profession do
      profession_name nil
    end

    trait :not_looking_for_work do
      looking_for_work false
    end
  end
end
