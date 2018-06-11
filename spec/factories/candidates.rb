FactoryBot.define do
  factory :candidate do
    email { Faker::Internet.email }
    password "foobar2000"
    confirmed_at Time.now
    association :profile, factory: :candidate_profile

    transient do
      profession_name nil
    end

    after(:create) do |cand, ev|
      if ev.profession_name && cand.profile.present?
        cand.profile.update_column(:profession_name, ev.profession_name)
      end
    end

    trait :only_login_credentials do
      association :profile, factory: [:candidate_profile, :only_name]
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
