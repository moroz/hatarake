class PagesController < ApplicationController
  expose :page, fetch: -> { fetch_page }
  def show
  end

  def edit
    @title = "Editing page: #{page.title}"
    render 'new'
  end

  def update
    if page.update(page_params)
      flash[:success] = "The page was updated."
      redirect_to page
    end
  end

  private

  def fetch_page
    permalink = params[:permalink] || params[:id]
    if permalink.present?
      @page = Page.find_by(permalink: permalink)
      raise ActiveRecord::RecordNotFound if @page.nil?
      @page
    end
  end

  def page_params
    params.require(:page).permit(:title, :body, :permalink)
  end
end
