FactoryGirl.define do
  factory :company do
    name "InJobs Inc."
    email { Faker::Internet.email }
    password "foobar2000"
  end
end
