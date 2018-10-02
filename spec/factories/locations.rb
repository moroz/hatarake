# frozen_string_literal: true

FactoryBot.define do
  factory :location do
    country { Country.first || create(:country) }
    province { Province.first || create(:province) }
    city { Faker::Address.city }
    offer

    trait :russia do
      country { Country.find_by(iso: 'RU') || create(:country, :russia) }
    end

    trait :germany do
      country { Country.find_by(iso: 'DE') || create(:country, :germany) }
    end

    trait :poland do
      country { Country.find_by(iso: 'PL') || create(:country, :poland) }
    end

    # this won't work in test environment due to empty DB
    trait :random do
      country { @country = Country.all.to_a.sample || create(:country) }
      province { Province.where(country: @country).to_a.sample || create(:province) }
    end
  end
end
