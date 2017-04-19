class OffersController < ApplicationController
  expose :offer
  expose :offers, -> { Offer.all }

  def show
  end

  def index
  end

  def edit
    @title = "Editing offer: #{offer.title}"
    render 'new'
  end
  
  def create
    if @offer = current_company.offers.create(offer_params)
      redirect_to @offer
    else
      render :new, offer: offer
    end
  end

  def update
    if offer.update(offer_params)
      flash[:success] = "The offer was updated."
      redirect_to offer
    else
      @title = "Editing offer: #{offer.title}"
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

  def current_company
    super || Company.first # only testing
  end

  def offer_params
    params.require(:offer).permit(:title, :currency, :salary_min,
                                  :salary_max, :contact_email, :contact_phone, :location, :description)
  end
end
