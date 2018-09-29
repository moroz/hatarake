# frozen_string_literal: true

xml.instruct!
xml.countries do
  @countries.each do |country|
    xml.country do
      xml.country_name country.name_en
      xml.country_id country.id
      xml.provinces do
        country.provinces.each do |province|
          xml.province do
            xml.province_name province.name_en
            xml.province_id province.id
          end
        end
      end
    end
  end
end
