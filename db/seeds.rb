# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed
# command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
files = Dir[File.expand_path(Rails.root + 'db/seeds/*')]
files.each do |f|
  load f
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

Country.create!(id: 166, iso: 'PL', name_pl: 'Polska', name_en: 'Poland')
Country.create!(id: 167, iso: 'DE', name_pl: 'Niemcy', name_en: 'Germany')
Country.create!(id: 168, iso: 'RU', name_pl: 'Rosja',  name_en: 'Russia')

company = Company.create!(name: 'Test company', email: 'test@example.com', password: 'zaq123', password_confirmation: 'zaq123')
company.confirm

500.times { |i| Offer.create!(company_id: company.id, title: "test nowy #{i}", currency: 'pln', description: 'test') }

countries = Country.all
Offer.all.each { |o| Location.create!(country_id: countries.sample.id, offer_id: o[:id]) }

Product.create!(name_pl: 'Produkt', name_en: 'Product', price_eur: 10.0, price_pln: 40.0, description_pl: 'Test', description_en: 'Test', backend_name: 'test')
