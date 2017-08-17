class HomeController < ApplicationController
  layout 'home'

  def home
		@offers = Offer.includes(:company, location: [:country]).homepage_featured.limit(20)
    @companies = Company.includes(:avatar).featured.with_avg_rating
    @offer_counts = @companies.offer_counts
  end
end
