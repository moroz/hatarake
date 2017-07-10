class HomeController < ApplicationController
  layout 'home'

  def home
		@offers = Offer.includes(:company, location: [:country]).featured.limit(4)
    @companies = Company.featured.with_avg_rating.limit(4)
    @offer_counts = @companies.offer_counts
  end
end
