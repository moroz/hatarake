# frozen_string_literal: true

class ImportedOffersController < ApplicationController

  def select_company
    @companies = Company.all
  end

  def publish
    offers = ImportedOffer.find(params['offers_ids'].split(','))
    offers = ImportedOffer.prepare_to_publish(offers, company_id: params['company_id'])

    existing_ids = Offer.pluck(:external_id).compact
    offers.each do |offer|
      locations = offer.delete(:locations)

      next if existing_ids.include?(offer[:external_id])

      offer = Offer.create(offer)
      ImportedOffer.find_by(external_id: offer[:external_id]).publish
      locations.each { |location| Location.create(location.merge(offer_id: offer.id)) } if locations
    end

    redirect_to admin_imported_offers_path
  end

  def update
    require 'pry'
    binding.pry
    super
  end

end
