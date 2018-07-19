xml.instruct!
xml.jobs do
  @offers.each do |offer|
    xml.job do
      xml.id offer.id
      xml.link { xml.cdata! offer_url(offer) }
      xml.name { xml.cdata! offer.title }
      xml.region { xml.cdata! offer.locations.first.xml_region }
      xml.country { xml.cdata! offer.locations.first.country.name_en }
      xml.apply_url { xml.cdata! offer_url(offer) } # TODO: Should be application_url_for, but that doesn't work out well
      xml.pubdate offer.published_at.strftime("%d.%m.%Y")
      xml.email { xml.cdata! offer.application_email }
      xml.company { xml.cdata! offer.company.name }
      xml.updated offer.updated_at.strftime("%d.%m.%Y")
      xml.salary { xml.cdata! xml_salary_for(offer) } if offer.salary.present?
      xml.phone { xml.cdata! offer.contact_phone } if offer.contact_phone.present?
      xml.description { xml.cdata! markdown(offer.description) }
      xml.segmentation { xml.cdata! "promo_#{(!!offer.featured?).to_s}" }
    end
  end
end
