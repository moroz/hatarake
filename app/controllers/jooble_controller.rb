class JoobleController < ApplicationController
  respond_to :xml

  def feed
    @offers = Offer.published
  end
end
