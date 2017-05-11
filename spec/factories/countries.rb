FactoryGirl.define do
  factory :country do
    iso "PL"
    name_pl "Polska"
    name_en "Poland"

    trait :russia do
      iso "RU"
      name_pl "Rosja"
      name_en "Russia"
    end

    trait :germany do
      iso "DE"
      name_pl "Niemcy"
      name_en "Germany"
    end
  end
end
