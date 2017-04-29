class ProvincesController < ApplicationController
  respond_to :js

  def index
    if params[:country_id].blank?
      render json: {}, head: :no_content
    end
    @provinces = Province.
      where(country_id: params[:country_id]).
      order(:name_en)
  end
end
