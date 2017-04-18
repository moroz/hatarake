class OffersController < ApplicationController
  expose :offer
  expose :offers, -> { Offer.all }

  def show
  end

  def index
  end
end
