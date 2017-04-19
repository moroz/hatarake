class PagesController < ApplicationController
  expose :page, find_by: :permalink
  expose :pages, -> { Page.all }

  authorize_resource

  def new
  end

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

  def page_params
    params.require(:page).permit(:title, :body, :permalink)
  end
end
