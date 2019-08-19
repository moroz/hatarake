# frozen_string_literal: true

FactoryBot.define do
  factory :candidate_profile do
    first_name { 'Example' }
    last_name { 'User' }
    profession_name { 'Carpenter' }
    birth_date { 20.years.ago }
    looking_for_work { true }
    sex { 1 } # 1 male 2 female 3 apache_helicopter

    trait :only_name do
      profession_name { nil }
      birth_date { nil }
      looking_for_work { nil }
      sex { nil }
      to_create { |instance| instance.save(validate: false) }
    end
  end
end
