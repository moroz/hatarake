class HomeController < ApplicationController
  layout 'home'

  def home
		@offers = Offer.featured.limit(5)
    @companies = Company.featured.limit(5)
  end
end
