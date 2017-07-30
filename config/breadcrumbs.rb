crumb :root do
  link "Home", root_path
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
  parent offer.location.poland? ? :jobs_poland : :jobs_abroad
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
  link I18n.t('dashboards.company_dashboard.my_offers')
  parent :company_dashboard
end
