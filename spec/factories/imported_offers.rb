# frozen_string_literal: true

FactoryBot.define do
  factory :imported_offer do
    company_id { (Company.first || create(:company)).id }
    title { Faker::Job.title }
    salary { "[#{rand(1..10) * 1000},#{rand(11..15) * 1000}]" }
    currency { 'pln' }
    description { Faker::Lorem.paragraphs(8, true).join("\n\n") }
    contact_email { Faker::Internet.email }
    contact_phone { Faker::PhoneNumber.cell_phone }
    apply_on_website { false }
    published { false }
    location { 'pl|poznan'}
  end
end
