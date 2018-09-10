# frozen_string_literal: true

FactoryBot.define do
  factory :country do
    iso 'UA'
    name_pl 'Ukraina'
    name_en 'Ukraine'

    trait :poland do
      id 166
      iso 'PL'
      name_pl 'Polska'
      name_en 'Rosja'
    end

    trait :russia do
      iso 'RU'
      name_pl 'Rosja'
      name_en 'Russia'
    end

    trait :germany do
      iso 'DE'
      name_pl 'Niemcy'
      name_en 'Germany'
    end
  end
end
