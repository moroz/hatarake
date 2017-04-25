FactoryGirl.define do
  factory :candidate_profile do
    first_name "Example"
    last_name "User"
    birth_date { 20.years.ago }
    looking_for_work true
  end
end
