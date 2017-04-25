FactoryGirl.define do
  factory :candidate_profile do
    user nil
    first_name "MyString"
    last_name "MyString"
    birth_date "2017-04-25"
    looking_for_work false
    profession nil
  end
end
