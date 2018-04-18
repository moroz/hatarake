module CompaniesHelper
  def prepare_company_meta_description(company)
    contact_website = company.website if company.website.present?
    description = ActionView::Base.full_sanitizer.sanitize(company.description) if company.description.present?
    if description.nil? && contact_website.nil?
      description = "Niestety firma #{company.name} nie udostępniła nam żadnych informacji o swojej działalności."
    end
    if description.nil? && !contact_website.nil?
      description = "Firma #{company.name} nie uzupełnia jeszcze swojego opisu, jednak możesz znaleźć więcej informacji na stronie #{company.website}."
    end
    return description
  end
end
