FactoryGirl.define do
  factory :candidate do
    email { Faker::Internet.email }
    password "foobar2000"
    profession_name "Carpenter"
    association :profile, factory: :candidate_profile

    trait :no_profession do
      profession_name nil
    end

    trait :not_looking_for_work do
      looking_for_work false
    end
  end
end
