class CvItemsController < ApplicationController
  expose :cv_item
  expose :cv_items, -> {current_user.cv_items}

  def new
    render 'index'
  end

  def create
    if cv_item.save
      redirect_to cv_items_path
    else
      @cv_item = cv_item
      render :index
    end
  end

  def destroy
    if cv_item.destroy
      flash[:success] = "The entry was deleted."
    else
      flash[:alert] = "There was an error processing your request."
    end
    redirect_to cv_items_path
  end

  private

  def cv_item_params
    params.require(:cv_item).permit(:start_month, :start_year, :end_month, :end_year,
                                    :organization_name, :position, :category)
  end
end
