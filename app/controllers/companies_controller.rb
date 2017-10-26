# frozen_string_literal: true

class CompaniesController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  helper_method :company

  before_action :set_province_list, only: :edit
  before_action :set_country_list, only: :edit

  authorize_resource

  def index
    @companies = Company.includes(:avatar).page(params[:page])
    @companies = if params[:q].present?
                   @companies.order('LOWER(name)').search(params[:q])
                 else
                   @companies.order('premium_until DESC NULLS LAST, published_offers_count DESC')
                 end
    respond_to do |f|
      f.html
      f.js
      f.xlsx do
        @companies = Company.order('LOWER(name)')
        render xlsx: 'index', filename: Time.zone.now.strftime('%Y%m%d_pracodawcy.xlsx')
      end
    end
  end

  def mailing_list
    @collection = Company.order('LOWER(name)') 
    render 'mailing_list.txt', layout: false, content_type: 'text/plain'
  end

  def edit
    if company_signed_in?
      @company = current_company
      @company.build_location
    else
      redirect_to root_path
    end
  end

  def show
    if request.path != company_path(company)
      redirect_to company, status: :moved_permanently
    end
    @blog_posts = company.blog_posts.ordered
    @recent_offers = company.recent_offers.with_associations
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
    elsif company_signed_in?
      @company = current_user
    end
  end

  def company_params
    params.require(:company).permit(:name, :website, :description, location_attributes: [:country_id, :province_id, :city])
  end

  def set_province_list
    if @company.location.try(:country).present?
      @provinces = @company.location.country.provinces.local_order
    else
      @provinces = Province.where(country_id: Country::POLAND_ID).local_order
    end
  end

  def set_country_list
    @countries = Country.local_order
  end
end
