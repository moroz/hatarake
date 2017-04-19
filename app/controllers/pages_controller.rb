class PagesController < ApplicationController
  def show
    if params[:permalink].present?
      @page = Page.find_by(permalink: params[:permalink])
      raise ActiveRecord::RecordNotFound if @page.nil?
    end
  end
end
