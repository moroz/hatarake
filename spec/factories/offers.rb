FactoryBot.define do
  factory :offer do
    company { Company.first || create(:company) }
    title { Faker::Job.title }
    salary_min { @smin = rand(10) * 1000 }
    salary_max { @smin + 2500 }
    currency "pln"
    description { Faker::Lorem.paragraphs(8, true).join("\n\n") }
    contact_email { Faker::Internet.email }
    contact_phone { Faker::PhoneNumber.cell_phone }
    apply_on_website false
    unpublished
    unfeatured

    trait :random do
      #association :location, :random
    end

    trait :published do
      published_at { 1.day.ago }
    end

    trait :homepage_featured do
      featured_until { 2.weeks.from_now }
    end

    trait :category_featured do
      category_until { 2.weeks.from_now }
    end

    trait :highlighted do
      highlight_until { 2.weeks.from_now }
    end

    trait :social_featured do
      social_until { 2.weeks.from_now }
    end

    trait :special_featured do
      special_until { 2.weeks.from_now }
    end

    trait :unfeatured do
      featured_until nil
      category_until nil
      highlight_until nil
      social_until nil
      special_until nil
    end

    %i{ russia poland germany }.each do |country|
      trait country do
        association :location, country
      end
    end

    trait :unpublished do
      published_at nil
    end

    trait :apply_on_website do
      apply_on_website true
      application_url 'https://www.injobs.pl'
    end
  end
end
