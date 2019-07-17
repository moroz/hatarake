# frozen_string_literal: true

xml.instruct!
xml.jobs do
  @offers.each do |offer|
    xml.job do
      xml.title { xml.cdata! offer.title }
      xml.id offer.id
      xml.description { xml.cdata! markdown(offer.description) }
      xml.link { xml.cdata! offer_url(offer) }
      xml.location { xml.cdata! [offer.locations.first.country.name_en, offer.locations.first.xml_region].reject(&:blank?).join(', ') }
      xml.company { xml.cdata! offer.company.name }

      salary_frequency = if offer.salary
                           'hour'
                         elsif offer.hourly_wage
                           'month'
                        end

      if salary_frequency
        salary_column = salary_frequency == 'hour' ? :hourly_wage : :salary
        xml.salary { xml.cdata! xml_salary_for(offer, salary_column, " per #{salary_frequency}") }
        xml.salary_min { xml.cdata! localized_currency_value(offer.salary.first) }
        xml.salary_max { xml.cdata! localized_currency_value(offer.salary.first) }
        xml.salary_frequency { xml.cdata! salary_frequency }
        xml.salary_currency { xml.cdata! offer.currency }
      end

      xml.category { xml.cdata! offer.field.name_en } if offer.field

      xml.date { xml.cdata! offer.published_at.strftime('%F') }
    end
  end
end
