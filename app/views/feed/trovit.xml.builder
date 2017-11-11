xml.instruct!
xml.trovit do
  @offers.each do |offer|
    xml.ad do
      xml.id offer.id
      xml.title { xml.cdata! offer.title }
      xml.url { xml.cdata! offer_url(offer) }
      xml.company { xml.cdata! offer.company.name }
      xml.salary { xml.cdata! xml_salary_for(offer) } if offer.salary.present?
      xml.city { xml.cdata! offer.location.city } if offer.location.city.present?
      xml.region { xml.cdata! offer.location.trovit_region }
      xml.date offer.published_at.strftime('%d-%m-%Y %H:%M:%S')
      xml.contact_email { xml.cdata! offer.application_email }
      xml.contact_telephone { xml.cdata! offer.contact_phone } if offer.contact_phone.present?
      xml.content { xml.cdata! markdown(offer.description) }
    end
  end
end
