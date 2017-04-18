FactoryGirl.define do
  factory :company do
    name "InJobs Inc."
    birth_date { 20.years.ago }
    email { Faker::Internet.email }
    password "foobar2000"
  end
end
