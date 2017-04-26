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
  end
end
