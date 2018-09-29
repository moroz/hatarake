# frozen_string_literal: true

FactoryBot.define do
  factory :province do
    country { Country.first || create(:country) }
    name_en 'Brandenburg'
    name_pl 'Brandenburgia'

    trait :mazovia do
      country { Country.find_by(iso: 'PL') || create(:country) }
      name_en 'Mazovia'
      name_pl 'mazowieckie'
    end

    trait :gp do
      country { Country.find_by(iso: 'PL') || create(:country) }
      name_en 'Greater Poland'
      name_pl 'wielkopolskie'
    end
  end
end
