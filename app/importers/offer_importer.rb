class OfferImporter

  def self.root_url
    raise 'Not Implemented'
  end

  def self.import
    offers_response = RestClient.get(root_url)
    Hash.from_xml(offers_response.body).deep_symbolize_keys
  end

  def self.map_schema(offer)
    offer = offer.dup

    schema.each do |schema|
      if (internal_schema = schema[:internal]) && internal_schema.is_a?(Array)
        offer[internal_schema.first] ||= {}
        offer[internal_schema.first].merge!("#{internal_schema.second}": offer.delete(schema[:external]))
      else
        offer[schema[:internal]] = offer.delete(schema[:external])
      end
    end

    offer
  end

  # def self.import_offers
  #   # It's not working in development mode as eager loading is turned off
  #   # self.subclasses.flat_map { |subclass| subclass.import }
  #   SilverhandService.import
  # end

end
