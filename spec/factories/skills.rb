# frozen_string_literal: true

FactoryBot.define do
  factory :skill_item do
    level 1
    candidate
    skill_name 'Bulgarian'
  end

  factory :skill do
    name_en 'Chinese'
    name_pl 'Język chiński'
  end
end
