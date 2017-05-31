FactoryGirl.define do
  factory :offer do
    company { Company.first || create(:company) }
    title "Welder m/f"
    location
    salary_min 1000
    salary_max 2000
    currency "pln"
    description "We're looking for welders. *bold* _italic_"
    contact_email "user@example.com"
    contact_phone "555 100-800"
    unpublished

    trait :published do
      published true
      published_at { 1.day.ago }
    end

    %i{ russia poland germany }.each do |country|
      trait country do
        association :location, country
      end
    end

    trait :unpublished do
      published false
      published_at nil
    end
  end
end
