class OffersController < ApplicationController
  expose :offer, scope: -> { Offer.friendly }
  helper_method :offers

  before_action :set_country_list, only: [:new, :edit, :index]
  before_action :set_province_list, only: [:new, :edit, :poland]
  authorize_resource except: [:index, :poland, :abroad]

  invisible_captcha only: [:create, :update]

  def new
    offer.build_location
  end

  def index
    @offers = Offer.with_associations.published_or_owned_by(current_user).advanced_search(params).page(params[:page])
    set_search_description
    respond_to do |f|
      f.js
      f.html
    end
  end

  def my_offers
    @offers = current_company.offers.with_associations
  end

  def poland
    @offers = Offer.with_associations.poland.published_or_owned_by(current_user).advanced_search(params).page(params[:page])
    @popular_locations = Province.most_popular_voivodeships_with_counts
    set_search_description
    respond_to do |f|
      f.js { render 'index' }
      f.html
    end
  end

  def abroad
    @offers = Offer.with_associations.abroad.published_or_owned_by(current_user).advanced_search(params).page(params[:page])
    @popular_locations = Country.most_popular_with_offer_counts
    set_search_description
    set_province_list if params[:cid].present?
    respond_to do |f|
      f.js { render 'index' }
      f.html
    end
  end

  def show
    if request.path != offer_path(offer)
      redirect_to offer, status: :moved_permanently
    end
    offer.increment!(:views) unless offer.company_id == current_user.try(:id)
    @company = offer.company
    @offers = @company.offers.where("id != ?", offer.id).limit(5)
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

  def offers
    @offers ||= published_or_own
  end

  def set_province_list
    if offer.present? && offer.persisted?
      @provinces = offer.location.country.provinces.local_order
    else
      @provinces = Province.where(country_id: params[:cid] || Country::POLAND_ID).local_order
    end
  end

  def set_search_description
    @search_description = view_context.search_description(params)
  end

  def offer_params
    params.require(:offer).permit(:title, :currency, :salary_min, :salary_max, :contact_email, :contact_phone, :description, :hourly_wage_min, :hourly_wage_max, location_attributes: [:id, :country_id, :province_id, :city])
  end
end
