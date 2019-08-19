# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    user { Company.first || FactoryBot.create(:company) }
    cart { create :cart, :with_items, user: user }
    payment_status { 'new' }
    paid_at { nil }
    currency { 'pln' }

    trait :paid do
      paid_at { 2.days.ago }
    end

    trait :with_billing_address_attributes do
      billing_address_attributes do
        {
          first_name: 'Miś',
          last_name: 'Uszatek',
          street: 'ul. Sezamkowa',
          house_no: '13',
          postal_code: '75-500',
          city: 'Koszalin',
          nip: '725-18-01-126'
        }
      end
    end
  end
end
