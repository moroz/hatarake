class HomeController < ApplicationController
  def home
		@offers = Offer.recent.limit(5)
  end
end
