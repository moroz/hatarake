crumb :root do
  link "Home", root_path
end

crumb :jobs_abroad do
  link I18n.t('offers.index.heading'), jobs_abroad_path
  parent :root
end

crumb :jobs_poland do
  link I18n.t('offers.poland.heading'), jobs_poland_path
  parent :root
end

crumb :offer do |offer|
  link offer.title, offer_path(offer)
  parent offer.location.poland? ? :jobs_poland : :jobs_abroad
end

crumb :companies do
  link I18n.t('companies.index.heading'), companies_path
  parent :root
end

# in the future this will go back to industry
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
# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
