# frozen_string_literal: true

class ProvincesController < ApplicationController
  respond_to :js

  def index
    render json: {}, head: :no_content if params[:country_id].blank?
    @provinces = Province
                 .where(country_id: params[:country_id]).local_order
  end
end
