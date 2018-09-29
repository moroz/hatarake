# frozen_string_literal: true

class ImportController < ApplicationController
  def hrlink
    offers = Import.hrlink_xml_map
    offer_attributes = Import.attributes
    offers.each do |offer|
      offer["locations"] = [offer["locations"]]
      offer = offer_attributes.merge(offer.slice(*offer_attributes.keys))
      locations = offer['locations']
      offer.except!('locations')
      offer = Offer.new(offer)
      binding.pry
      offer.save!
    end
  end
end
