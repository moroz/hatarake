# frozen_string_literal: true

class OffersController < ApplicationController
  expose :offer, scope: -> { Offer.friendly }
  helper_method :offers

  before_action :set_country_list, only: %i[new edit abroad]
  before_action :set_province_list, only: %i[new edit]
  authorize_resource except: %i[index poland abroad no_offer_found]

  invisible_captcha only: %i[create update]

  SEARCH_PARAMS = %i[cid pid q smin cur].freeze
  CATEGORY_FEATURED_LIMIT = 5

  def new
    offer.locations.build
    @fields = Field.all
    @provinces = [@provinces]
    respond_to do |f|
      f.html
    end
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

  def promote; end

  def add_premium
    method = params[:method]
    if offer.featured?(method)
      redirect_to promote_offer_path(offer), alert: t("offers.promote.already_featured.#{method}")
      return
    end
    unless offer.company.reduce_premium_services(method, 1)
      current_cart.add_item(Product.find_by(backend_name: method).id, 1, [offer.id])
      redirect_to(cart_path) && return
    end
    offer.publish unless offer.published?
    if offer.add_premium(params[:method])
      redirect_to my_offers_path, notice: t("offers.promote.success.#{method}")
    else
      redirect_to promote_offer_path(offer), alert: t('offers.promote.error')
    end
  end

  # Getting random records from the database can be hard on performance
  # TODO: Write a stored procedure to get random records
  def poland
    @offers = Offer.with_associations.poland.published_or_owned_by(current_user)
                   .featured_first.advanced_search(params).group(:id).page(params[:page])
    @total_count = Offer.poland.published_or_owned_by(current_user)
                        .advanced_search(params).group(:id).reorder('').count.length
    ids = nil
    ids = @offers.pluck(:id) if search_params_present? && @total_count < 50

    set_search_description
    get_featured_offers(:poland, ids) if search_params_present? && @offers.last_page?
    respond_to do |f|
      f.js { render 'index' }
      f.html do
        set_province_list
        @fields = Field.all
        @popular_locations = Province.most_popular_voivodeships_with_counts.uniq
      end
    end
  end

  def abroad
    @offers = Offer.with_associations.abroad.published_or_owned_by(current_user)
                   .featured_first.advanced_search(params).group(:id).page(params[:page])
    @total_count = Offer.abroad.published_or_owned_by(current_user)
                        .advanced_search(params).group(:id).reorder('').count.length
    ids = nil
    ids = @offers.pluck(:id) if search_params_present? && @total_count < 50

    set_search_description
    set_province_list if params[:cid].present?
    get_featured_offers(:abroad, ids) if search_params_present? && @offers.last_page?
    respond_to do |f|
      f.js { render 'index' }
      f.html do
        @fields = Field.all
        @popular_locations = Country.most_popular_with_offer_counts
      end
    end
  end

  def show
    redirect_to offer, status: :moved_permanently if request.path != offer_path(offer)
    offer.increment!(:views) unless offer.company_id == current_user&.id
    @company = offer.company
    @title = t('.title') + offer.title + ', ' + offer.locations.first.only_city_format
  rescue ActiveRecord::RecordNotFound
    redirect_to jobs_outdated_offer_path
  end

  def edit
    @title = t('.title') + offer.title
    @fields = Field.all
    render 'new'
  end

  def create
    offer.company = current_company
    if params['offer']['locations_attributes'].nil?
      flash[:alert] = "Update your browser and then try post your offer again.
          If it won't help contact with administrator."
      redirect_to(root_path) && return
    end
    if offer.save
      flash[:success] = 'Your offer has been saved.'
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
      offer.remove_locations(offer_params['locations_attributes'])
      flash[:success] = 'The offer was updated.'
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

  def batch_action
    redirect_to(my_offers_path, alert: t('offers.my_offers.no_offers_selected')) && return if params[:offer_ids].blank?
    @offers = Offer.where(id: params[:offer_ids])
    update_action = if params.key?('apply_bulk_action_top')
                      params['update_action_top']
                    else
                      params['update_action']
                    end
    case update_action
    when 'publish'
      @offers.publish_all
    when 'unpublish'
      @offers.unpublish_all
    when 'highlight', 'homepage', 'category', 'social', 'special'
      offers = @offers.add_premium(update_action)
      if offers == false
        current_cart.add_item(Product.find_by(backend_name: update_action).id, @offers.count, params[:offer_ids])
        redirect_to(cart_path) && return
      end
    else
      raise ActionController::BadRequest.new, 'Unrecognized action'
    end
    redirect_to my_offers_path
  end

  def unpublish
    offer.unpublish
    redirect_to offer, notice: 'The offer has been unpublished.'
  end

  def publish
    offer.publish
    redirect_to offer, notice: 'The offer has been published.'
  end

  def destroy
    title = offer.title
    return unless offer.destroy
    flash[:success] = "Offer \"#{title}\" has been deleted."
    redirect_to my_offers_path
  end

  def no_offer_found
    if current_locale.to_s == 'pl'
      get_featured_offers(:poland)
    else
      get_featured_offers(:aborad)
    end
    respond_to do |f|
      f.html
    end
  end

  private

  def search_params_present?
    SEARCH_PARAMS.each do |key|
      return true if params[key].present?
    end
    false
  end

  def get_featured_offers(scope, ids = nil, lim = CATEGORY_FEATURED_LIMIT)
    @featured = Offer.published.with_associations.category_featured.random_order.limit(lim).group(:id)
    @featured = if scope == :poland
                  @featured.poland
                else
                  @featured.abroad
                end
    @featured = @featured.where('offers.id NOT IN (?)', ids) if ids.present?
  end

  def page_present?
    params[:page].present? && params[:page] != '1'
  end

  def offers
    @offers ||= published_or_own
  end

  def set_province_list
    if offer.present? && offer.persisted?
      @provinces = []
      offer.locations.each { |o| @provinces << o.country.provinces.local_order }
    else
      @provinces = Country.find(params[:cid] || Country::POLAND_ID).provinces.local_order
    end
  end

  def set_search_description
    @search_description = view_context.search_description(params)
  end

  def offer_params
    params.require(:offer).permit(:title, :currency, :salary_min, :salary_max, :contact_email,
                                  :contact_phone, :apply_on_website, :application_url,
                                  :description, :hourly_wage_min, :hourly_wage_max,
                                  :field_id, :req_lang_1, :req_lang_2,
                                  locations_attributes: %i[id country_id province_id city _destroy])
  end
end
