class OffersController < ApplicationController
  expose :offer, scope: -> { Offer.friendly }
  helper_method :offers

  before_action :set_country_list, only: [:new, :edit, :index]
  authorize_resource

  def index
    @offers = published_or_own
    if params[:cid].present?
      @offers = @offers.where(country_id: params[:cid])
    end
    if params[:pid].present?
      @offers = @offers.where(province_id: params[:pid])
    end
    if params[:cur].present?
      @offers = @offers.where(currency: params[:cur])
    end
    if params[:q].present?
      @offers = @offers.search_by_query(params[:q])
    end
    if params[:smin].present?
      @offers = @offers.with_min_salary(params[:smin])
    end
    respond_to do |f|
      if request.xhr?
        f.js
      else
        f.html
      end
    end
  end

  def show
    if request.path != offer_path(offer)
      redirect_to offer, status: :moved_permanently
    end
  end

  def edit
    @title = t('.title') + offer.title
    render 'new'
  end
  
  def create
    offer.company = current_company
    if offer.save
      flash[:success] = "Your offer has been saved."
      redirect_to offer
    else
      set_country_list
      render :new
    end
  end

  def update
    if offer.update(offer_params)
      flash[:success] = "The offer was updated."
      redirect_to offer
    else
      @title = t('.title') + offer.title
      set_country_list
      render 'new'
    end
  end

  def unpublish
    offer.unpublish
    flash[:notice] = "The offer has been unpublished."
    redirect_to offer
  end

  def publish
    offer.publish
    flash[:notice] = "The offer has been published."
    redirect_to offer
  end

  def destroy
    title = offer.title
    if offer.destroy
      flash[:success] = "Offer \"#{title}\" has been deleted."
      redirect_to offers_path
    end
  end

  private

  def published_or_own
    scope = if company_signed_in?
      Offer.published_or_owned_by(current_company)
    else
      Offer.published
    end
    scope = scope.page(params[:page])
  end

  def offers
    @offers ||= published_or_own
  end

  def set_country_list
    @countries = Country.all.order(local_name)
    if offer.present? && offer.persisted?
      @provinces = offer.country.provinces.local_order
    else
      @provinces = Province.where(country_id: 166).local_order
    end
  end

  def offer_params
    params.require(:offer).permit(:title, :currency, :salary_min,
                                  :salary_max, :contact_email, :contact_phone, :location, :description, :country_id, :province_id)
  end
end
