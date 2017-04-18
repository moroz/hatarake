FactoryGirl.define do
  factory :offer do
    company { Company.first || create(:company) }
    salary_min 1000
    salary_max 2000
    currency "PLN"
    description "We're looking for welders."
    contact_email "user@example.com"
    contact_phone "555 100-800"
  end
end
