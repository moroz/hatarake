class CompaniesController < ApplicationController
  before_action :find_user, only: :show
  helper_method :company

  before_action :set_province_list, only: :edit
  before_action :set_country_list, only: :edit

  expose :companies {
    Company.includes(:avatar).with_avg_rating.
      page(params[:page])
  }
  authorize_resource
  def index

    @offer_counts = companies.offer_counts
  end

  def edit
    if company_signed_in?
      @company = current_company
    else
      redirect_to root_path
    end
  end

  def show
    if request.path != company_path(company)
      redirect_to company, status: :moved_permanently
    end
    set_rating
  end

  def update
    company = current_company
    if company.update(company_params)
      redirect_to company
    else
      respond_to do |f|
        f.html {
          flash.alert = "The profile could not be saved."
        }
        f.js { render_js_errors_for company }
      end
    end
  end

  def vote
    value = Integer(params[:v]) rescue false
    if !value || !(1..5).include?(value)
      head 400 and return
    end
    company.add_or_update_evaluation(:avg_rating, value, current_user)
    set_rating
    respond_to do |f|
      f.js
    end
  end

  private

  def set_rating
    @rating = company.reputation_for(:avg_rating).round(2)
    @ratings_count = company.ratings_count
  end

  def company
    @company ||= find_user
  end

  def find_user
    if params[:id].present?
      @company = User.find(params[:id])
    elsif logged_in?
      @company = current_user
    end
  end

  def company_params
    params.require(:company).permit(:name, :website, :description, location_attributes: [:country_id, :province_id, :city])
  end

  def set_province_list
    if current_company.location.country.present?
      @provinces = current_company.location.country.provinces.local_order
    end
  end
end
