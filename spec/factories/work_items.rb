FactoryGirl.define do
  factory :work_item do
    candidate { Candidate.first || create(:candidate) }
    category "work"
    position "Merchandiser"
    organization "Jeronimo Martins Polska"
    start_date { 2.years.ago }
    end_date { 1.years.ago }

    trait :no_dates do
      start_date nil
      end_date nil
    end
  end
end
