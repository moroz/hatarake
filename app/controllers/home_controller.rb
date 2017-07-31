class HomeController < ApplicationController
  layout 'home'

  def home
		@offers = Offer.includes(:company, location: [:country]).homepage_featured.limit(20)
    @companies = Company.includes(:avatar).featured.with_avg_rating.limit(4)
    @offer_counts = @companies.offer_counts
  end
end
