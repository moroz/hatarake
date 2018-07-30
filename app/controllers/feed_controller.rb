# frozen_string_literal: true

class FeedController < ApplicationController
  respond_to :xml
  before_action :fetch_offers

  def jooble; end

  def trovit; end

  private

  def fetch_offers
    @offers = Offer.published.promoted.includes(:company, locations: [:country, :province])
  end
end
