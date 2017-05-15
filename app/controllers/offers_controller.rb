class OffersController < ApplicationController
  expose :offer, scope: -> { Offer.friendly }
  helper_method :offers

  before_action :set_country_list, only: [:new, :edit, :index]
  authorize_resource

  def index
    @offers = published_or_own.order(:published_at).advanced_search(params)
    @search_description = view_context.search_description(params)
    respond_to do |f|
      f.js
      f.html
    end
  end

  def show
    if request.path != offer_path(offer)
      redirect_to offer, status: :moved_permanently
    end
    @title = t('.title') + offer.title
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
      respond_to do |f|
        f.html do
          set_country_list
          render :new
        end
        f.js { render_js_errors_for(offer) }
      end
    end
  end

  def update
    if offer.update(offer_params)
      flash[:success] = "The offer was updated."
      redirect_to offer
    else
      respond_to do |f|
        f.html do
          @title = t('.title') + offer.title
          set_country_list
          render 'new'
        end
        f.js { render_js_errors_for(offer) }
      end
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
    params.require(:offer).permit(:title, :currency, :salary_min, :salary_max, :contact_email, :contact_phone, :location, :description, :country_id, :province_id, :hourly_wage_min, :hourly_wage_max)
  end
end
