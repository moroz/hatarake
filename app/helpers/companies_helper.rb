module CompaniesHelper
  def prepare_company_meta_description(company)
    description = ActionView::Base.full_sanitizer.sanitize(company.description) if company.description.present?
    description = t('companies.show.meta_description', company: company.name) if description.nil?
    return description
  end
end
