# frozen_string_literal: true

crumb :root do
  link 'Home', root_path
end

crumb :jobs_abroad do
  link I18n.t('offers.abroad.heading'), jobs_abroad_path
  parent :root
end

crumb :jobs_poland do
  link I18n.t('offers.poland.heading'), jobs_poland_path
  parent :root
end

crumb :job_search do
  link I18n.t('offers.index.heading'), offers_path
end

crumb :offer do |offer|
  link offer.title, offer_path(offer)
  parent offer.locations.first.poland? ? :jobs_poland : :jobs_abroad
end

crumb :companies do
  link I18n.t('companies.index.heading'), companies_path
  parent :root
end

crumb :company do |company|
  link company.name, company_path(company)
  parent :companies
end

crumb :company_offers do |company|
  link I18n.t('company_offers.index.breadcrumb'), company_offers_path(company_id: company.id)
  parent :company, company
end

crumb :company_offer do |offer|
  link offer.title, offer
  parent :company_offers, offer.company
end

crumb :offer_applications do |offer|
  link I18n.t('applications.breadcrumb'), offer_applications_path(offer)
  parent :offer, offer
end

crumb :company_dashboard do
  link I18n.t('dashboards.company_dashboard.heading'), dashboard_path
end

crumb :my_offers do
  link I18n.t('dashboards.company_dashboard.my_offers'), my_offers_path
  parent :company_dashboard
end

crumb :promote_offer do
  link I18n.t('offers.promote.breadcrumb')
  parent :my_offers
end

crumb :orders do
  link I18n.t('orders.index.heading'), orders_path
  parent :company_dashboard
end

crumb :admin_dashboard do
  link 'Panel administracyjny', admin_dashboard_path
end

crumb :admin_orders do
  link I18n.t('orders.index.heading'), admin_orders_path
  parent :admin_dashboard
end

crumb :admin_order do |order|
  link I18n.t('orders.show.heading', id: order.id)
  parent :admin_orders
end

crumb :order do |order|
  link I18n.t('orders.show.heading', id: order.id)
  parent :orders
end

crumb :order_premium do
  link I18n.t('products.index.breadcrumb')
  parent :company_dashboard
end

crumb :tos do
  link I18n.t('terms_of_service'), regulamin_path
end

crumb :tos_appendix do
  link 'Załącznik 1'
  parent :tos
end

crumb :profile do
  link I18n.t('nav.profile'), profile_path
end

crumb :edit_skills do
  link I18n.t('candidates.edit_skills.heading')
  parent :profile
end

crumb :work_experience do
  link I18n.t('candidates.show.work_experience')
  parent :profile
end

crumb :education do
  link I18n.t('candidates.show.education')
  parent :profile
end
