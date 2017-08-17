class CompanyOffersController < ApplicationController
  expose(:company)
  helper_method :company_offers

  def index
    respond_to do |f|
      f.html
      f.js do
        company_offers
        render 'offers/index.js'
      end
    end
  end

  def company_offers
    @offers ||= company.offers.with_associations.page(params[:page])
  end
end
