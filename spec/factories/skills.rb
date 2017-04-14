FactoryGirl.define do
  factory :skill do
    name "Welding"
    name_pl "Spawanie"
    level "beginner"
    candidate
  end

  factory :language_skill do
    name "Russian"
    name_pl "język rosyjski"
    lever "c1"
    candidate
  end
end
