FactoryGirl.define do
  factory :location do
    country { Country.first || create(:country) }
    province { Province.first || create(:province) }
    city "Norylsk"
    
    trait :russia do
      country { Country.find_by(iso: "RU") || create(:country, :russia) }
    end

    trait :germany do
      country { Country.find_by(iso: "DE") || create(:country, :germany) }
    end

    trait :poland do
      country { Country.find_by(iso: "PL") || create(:country, :poland) }
    end
    
  end
end
