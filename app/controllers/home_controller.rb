class HomeController < ApplicationController
  layout 'home'

  def home
		@offers = Offer.includes(:location).featured.limit(5)
    @companies = Company.featured.limit(5)
  end
end
