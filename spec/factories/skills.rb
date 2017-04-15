FactoryGirl.define do
  factory :skill_item do
    level "beginner"
    candidate
    skill_name "Bulgarian"
  end

  factory :skill do
    name "Chinese"
    name_pl "Język chiński"
  end
end
