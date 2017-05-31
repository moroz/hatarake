FactoryGirl.define do
  factory :offer do
    company { Company.first || create(:company) }
    title { Faker::Job.title }
    location
    salary_min { @smin = rand(10) * 1000 }
    salary_max { @smin + 2500 }
    currency "pln"
    description { Faker::Lorem.paragraphs(8, true).join("\n\n") }
    contact_email { Faker::Internet.email }
    contact_phone { Faker::PhoneNumber.cell_phone }
    unpublished

    trait :random do
      association :location, :random
    end

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
