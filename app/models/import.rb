class Import
  class << self
    def hrlink_xml_map
      xml = RestClient.get("https://webservice.hrlink.pl/sync/api/prezentacja/export.php")
      xml = Hash.from_xml(xml)#.fetch("ADS")
      offers = []
      xml["ADS"]["AD"].each do |offer|
        offer["title"] = offer["JOB_TITLE"]
        offer["locations"] = {}
        offer["locations"]["country"] = offer["CATEGORY"]
        offer["locations"]["state"] = offer["REGION_ID"]
        offer["locations"]["city"] = offer["CITY"]
        offer["application_url"] = offer["APPLY_LINK"]
        #offer["company"] = {}
        #offer["company"]["name"] = offer["COMPANY"]
        #offer["company"]["description"] = offer["O_PRACODAWCY"]
        #offer["company"]["avatar"] = offer["AVATAR"]
        offer["description"] = offer["ZAKRES_OBOWIAZKOW"]
        offer["description"] += offer["WYMAGANIA"]
        offer["description"] += offer["OFERUJEMY"]
        offers << offer
      end
      offers
    end

    def attributes
      attributes = Offer.new.attributes
      #attributes["company"] = {}
      #attributes["company"]["name"] = nil
      #attributes["company"]["description"] = nil
      #attributes["company"]["avatar"] = nil
      attributes["locations"] = []
      attributes["locations"][0] = {
        "country" => 14,
        "state" => 104,
        "city" => "Salzburg"
      }
      attributes['currency'] = "pln"

      attributes
    end
  end
end