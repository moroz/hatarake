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

500.times { |i| Offer.create!(company_id: company.id, title: "test nowy #{i}", currency: 'pln', description: 'test', salary: "[#{rand(0..1000)},#{rand(1000..2000)}]") }

products = JSON.parse("[{\"id\":8,\"name_pl\":\"Promowanie oferty w mediach społecznościowych\",\"name_en\":\"Promote offers in social media\",\"price_pln\":\"60.0\",\"price_eur\":\"15.0\",\"created_at\":\"2018-04-23T12:04:08.367+02:00\",\"updated_at\":\"2018-07-06T11:03:55.325+02:00\",\"description_en\":\"* Your offer will be promoted in social media\\r\\n\",\"description_pl\":\"* Twoja oferta będzie promowana w mediach społecznościowych\\r\\n\",\"backend_name\":\"social\",\"order\":6},{\"id\":1,\"name_pl\":\"Promowany Pracodawca\",\"name_en\":\"Premium Employer Bundle\",\"price_pln\":\"39.99\",\"price_eur\":\"10.0\",\"created_at\":\"2017-08-01T19:25:29.554+02:00\",\"updated_at\":\"2018-07-06T11:05:11.350+02:00\",\"description_en\":\"* Your company profile will be featured on the homepage\\r\\n\\r\\n\",\"description_pl\":\"* Wyróżnienie profilu Twojej firmy na stronie głównej serwisu\\r\\n\",\"backend_name\":\"homepage\",\"order\":5}]")
products.each { |p| Product.new(p.merge(id: '')).save }

countries = Country.all
Offer.all.each { |o| Location.create!(country_id: countries.sample.id, offer_id: o[:id]) }
Offer.all.sample(20).each { |offer| offer.add_premium('homepage') }
