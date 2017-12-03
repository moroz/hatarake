FactoryBot.define do
  factory :candidate_profile do
    first_name "Example"
    last_name "User"
    profession_name "Carpenter"
    birth_date { 20.years.ago }
    looking_for_work true
    sex 1 # 1 male 2 female 3 apache_helicopter
  end
end
