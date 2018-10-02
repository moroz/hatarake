# frozen_string_literal: true

class FeedController < ApplicationController
  respond_to :xml
  before_action :fetch_offers, except: :region_list

  def jooble; end

  def trovit; end

  def region_list
    @countries = Country.all
  end

  private

  def fetch_offers
    @offers = Offer.published.promoted.includes(:company, locations: %i[country province])
  end
end
