# frozen_string_literal: true

class FeedController < ApplicationController
  respond_to :xml
  before_action :fetch_offers, except: :region_list

  def action_missing(name)
    fetch_offers
  end

  def region_list
    @countries = Country.all
  end

  private

  def fetch_offers
    @offers = Offer.published.poland.includes(:company, locations: %i[country province])
                   .reorder(:updated_at).reverse_order.page(params[:page])
  end
end
