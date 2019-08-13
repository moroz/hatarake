# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    subscription { nil }
    subscription_price { nil }
    payment_fee { '9.99' }
  end
end
