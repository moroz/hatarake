FactoryGirl.define do
  factory :candidate do
    email { Faker::Internet.email }
    password "foobar2000"
    profession_name "Carpenter"
    association :profile, factory: :candidate_profile

    trait :only_login_credentials do
      profession_name nil
      profile nil
    end

    trait :no_profession do
      profession_name nil
    end

    trait :not_looking_for_work do
      association :profile, factory: :candidate_profile, looking_for_work: false
    end

    trait :looking_for_work do
      association :profile, factory: :candidate_profile, looking_for_work: true
    end
  end
end
