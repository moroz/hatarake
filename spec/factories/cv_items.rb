FactoryGirl.define do
  factory :cv_item do
    candidate { Candidate.first || create(:candidate) }
    category "ba"
    position "English Studies"
    organization_name "Adam Mickiewicz University"
    start_date { 2.years.ago }
    end_date { 1.years.ago }

    trait :no_dates do
      start_date nil
      end_date nil
    end

    trait :work do
      category "work"
      position "Merchandiser"
      organization_name "McDonald's"
    end
  end
end
