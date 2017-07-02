class HomeController < ApplicationController
  layout 'home'

  def home
		@offers = Offer.includes(:company, location: [:country]).featured.limit(5)
    @companies = Company.featured.limit(5)
  end
end
