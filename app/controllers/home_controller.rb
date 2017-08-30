class HomeController < ApplicationController
  layout 'home'

  def home
    @offers = Offer.includes(:company, location: [:country]).homepage_featured.random_order.limit(4)
    @companies = Company.includes(:avatar).featured.with_avg_rating.random_order
    @offer_counts = @companies.offer_counts
  end
end
