class OffersController < ApplicationController
  expose :offer
  expose :offers, -> { Offer.all }

  before_action :set_country_list, only: [:new, :edit]

  def show
  end

  def index
  end

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

  def destroy
    title = offer.title
    if offer.destroy
      flash[:success] = "Offer \"#{title}\" has been deleted."
      redirect_to offers_path
    end
  end

  private

  def set_country_list
    @countries = Country.all.order(:name_en)
  end

  def current_company
    super || Company.first # only testing
  end

  def offer_params
    params.require(:offer).permit(:title, :currency, :salary_min,
                                  :salary_max, :contact_email, :contact_phone, :location, :description, :country_id)
  end
end
