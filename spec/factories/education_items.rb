FactoryGirl.define do
  factory :education_item do
    candidate { Candidate.first || create(:candidate) }
    category "ba"
    specialization "English Studies"
    organization_name "Adam Mickiewicz University"
    start_date { 2.years.ago }
    end_date { 1.years.ago }

    trait :no_dates do
      start_date nil
      end_date nil
    end
  end
end
