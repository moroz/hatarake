class HomeController < ApplicationController
  layout 'home'

  def home
		@offers = Offer.includes(:company, location: [:country]).featured.limit(5)
    @companies = Company.featured.with_avg_rating.limit(5)
    @offer_counts = @companies.offer_counts
  end
end
