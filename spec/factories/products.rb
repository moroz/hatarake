# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    sequence(:name_pl) { |n| "Tłusty Boczek #{n}" }
    sequence(:name_en) { |n| "Chunky Bacon #{n}" }
    sequence(:backend_name) { |n| "homepage#{n}" }
    price_pln '30.00'
    price_eur '8.00'
    description_pl 'Tłusty boczek tłusty boczek'
    description_en 'Chunky bacon chunky bacon'
  end
end
