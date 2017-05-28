class HomeController < ApplicationController
  layout 'home'

  def home
    if signed_in?
      redirect_to dashboard_path and return
    end
		@offers = Offer.includes(:location).featured.limit(5)
    @companies = Company.featured.limit(5)
  end
end
