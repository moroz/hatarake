FactoryGirl.define do
  factory :cart do
    user factory: :company

    trait :empty do
      cart_items nil
    end

    trait :with_items do
      cart_items { create_list(:cart_item, 2) }
    end
  end
end
