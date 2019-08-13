# frozen_string_literal: true

FactoryBot.define do
  factory :billing_address do
    order
    first_name { 'Miś' }
    last_name { 'Uszatek' }
    nip { '725-18-01-126' }
    street { 'ul. Stepana Bandery' }
    house_no { '69a' }
    apt_no { '7' }
  end
end
