class CompanyOffersController < ApplicationController
  expose(:company)
  expose(:company_offers) { company.offers.published.includes(location: [:country, :province]).page(params[:page]) }

  def index
    respond_to do |f|
      f.html
      f.js do
        @offers = company_offers
        render 'offers/index.js'
      end
    end
  end
end
