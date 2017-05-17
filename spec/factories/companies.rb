FactoryGirl.define do
  factory :company do
    name "InJobs Inc."
    email { Faker::Internet.email }
    password "foobar2000"
    website "http://www.example.com"
  end
end
