FactoryGirl.define do
  factory :offer do
    company nil
    salary_min 1
    salary_max 1
    currency "MyString"
    description "MyText"
    contact_email "MyString"
    contact_phone "MyString"
  end
end
