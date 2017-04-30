class OffersController < ApplicationController
  expose :offer, scope: -> { Offer.friendly }
  expose :offers, -> { published_or_own }

  before_action :set_country_list, only: [:new, :edit]
  authorize_resource

  def edit
    @title = "Editing offer: #{offer.title}"
    render 'new'
  end
  
  def create
    offer.company = current_company
    if offer.save
      flash[:success] = "Your offer has been saved."
      redirect_to offer
    else
      flash[:alert] = "There was an error processing your request."
      set_country_list
      render :new
    end
  end

  def update
    if offer.update(offer_params)
      flash[:success] = "The offer was updated."
      redirect_to offer
    else
      @title = "Editing offer: #{offer.title}"
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

  def set_country_list
    @countries = Country.all.order(:name_en)
    if offer.persisted?
      @provinces = offer.country.provinces.order(:name_en)
    else
      @provinces = Province.where(country_id: 166).order(:name_en) # load Polish voivodeships
    end
  end

  def offer_params
    params.require(:offer).permit(:title, :currency, :salary_min,
                                  :salary_max, :contact_email, :contact_phone, :location, :description, :country_id, :province_id)
  end
end
