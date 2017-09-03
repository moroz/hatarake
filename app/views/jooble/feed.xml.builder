xml.instruct!
xml.jobs do
  @offers.each do |offer|
    xml.job do
      xml.id offer.id
      xml.link { xml.cdata! offer_url(offer) }
      xml.name { xml.cdata! offer.title }
      xml.region { xml.cdata! offer.location.xml_region }
      xml.country { xml.cdata! offer.location.country.name_en }
      xml.apply_url { xml.cdata! application_url_for(offer) }
      xml.pubdate offer.published_at.strftime("%d.%m.%Y")
      xml.email { xml.cdata! offer.application_email }
      xml.company { xml.cdata! offer.company.name }
      xml.updated offer.updated_at.strftime("%d.%m.%Y")
      xml.salary { xml.cdata! xml_salary_for(offer) } if offer.salary.present?
      xml.phone { xml.cdata! offer.contact_phone } if offer.contact_phone.present?
      xml.description { xml.cdata! markdown(offer.description) }
    end
  end
end
