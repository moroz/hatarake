# frozen_string_literal: true

xml.instruct!
xml.jobs do
  xml.prev_page { xml.cdata! path_to_prev_page(@offers).to_s }
  xml.next_page { xml.cdata! path_to_next_page(@offers).to_s }
  @offers.each do |offer|
    xml.job do
      xml.title { xml.cdata! offer.title }
      xml.id offer.id
      xml.description { xml.cdata! markdown(offer.description) }
      xml.link { xml.cdata! offer_url(offer) }
      xml.location { xml.cdata! [offer.locations.first.country.name_pl, offer.locations.first.xml_region].reject(&:blank?).join(', ') }
      xml.company { xml.cdata! offer.company.name }

      salary_frequency = if offer.salary.present?
                           'miesiąc'
                         elsif offer.hourly_wage.present?
                           'godzinę'
                         end

      if salary_frequency
        salary_column = salary_frequency == 'godzinę' ? :hourly_wage : :salary
        if (salary = offer.read_attribute(salary_column)) && !salary.blank?
          xml.salary { xml.cdata! xml_salary_for(offer, salary_column, " na #{salary_frequency}") }
          xml.salary_min { xml.cdata! localized_currency_value(salary.first) } if salary.first
          xml.salary_max { xml.cdata! localized_currency_value(salary.last) } if salary.last
          xml.salary_frequency { xml.cdata! salary_frequency }
          xml.salary_currency { xml.cdata! offer.currency }
        end
      end

      xml.category { xml.cdata! offer.field.name_pl } if offer.field

      xml.date { xml.cdata! offer.published_at.strftime('%F') }
      xml.updated_at { xml.cdata! offer.updated_at.iso8601 }
    end
  end
end
