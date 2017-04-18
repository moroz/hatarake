FactoryGirl.define do
  factory :candidate do
    first_name "Example"
    last_name "User"
    birth_date { 20.years.ago }
    email { Faker::Internet.email }
    password "foobar2000"
  end
end
