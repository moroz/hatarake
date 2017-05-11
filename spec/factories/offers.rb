FactoryGirl.define do
  factory :offer do
    company { Company.first || create(:company) }
    title "Welder m/f Berlin"
    location "Berlin"
    salary_min 1000
    salary_max 2000
    currency "pln"
    description "We're looking for welders. *bold* _italic_"
    country { Country.first || create(:country) }
    contact_email "user@example.com"
    contact_phone "555 100-800"
    unpublished

    trait :published do
      published true
      published_at { 1.day.ago }
    end

    trait :russia do
      country { Country.find_by(iso: "RU") || FactoryGirl.create(:country, :russia) }
    end

    trait :germany do
      country { Country.find_by(iso: "DE") || FactoryGirl.create(:country, :germany) }
    end

    trait :unpublished do
      published false
      published_at nil
    end
  end
end
