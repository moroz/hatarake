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
                   @companies.order('premium_until DESC NULLS LAST, published_offers_count DESC, updated_at DESC')
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
    if params["format"].nil?
      @collection = Company.order('LOWER(name)')
    else
      @collection = Company.where('id in (?)', params["format"].split('/')) 
    end
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

  private

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
