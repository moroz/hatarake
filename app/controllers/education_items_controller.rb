class EducationItemsController < ApplicationController
  expose :education_item
  expose :education_items, -> {current_user.education_items}

  def new
    render 'index'
  end

  def create
    education_item.candidate = current_user
    if education_item.save
      redirect_to education_items_path
    else
      @education_item = education_item
      render :index
    end
  end

  def destroy
    if education_item.destroy
      flash[:success] = "The entry was deleted."
    else
      flash[:alert] = "There was an error processing your request."
    end
    redirect_to education_items_path
  end

  private

  def education_item_params
    params.require(:education_item).permit(:start_date, :end_date,
                         :organization, :specialization, :category)
  end
end
