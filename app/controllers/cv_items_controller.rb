class CvItemsController < ApplicationController
  def create
    @cv_item = current_user.cv_items.new(cv_item_params)
    @cv_item.save
    redirect_to redirection_path_for(@cv_item)
  end

  def destroy
    @cv_item = current_user.cv_items.find_by(id: params[:id])
    if @cv_item.present? && @cv_item.destroy
      flash[:success] = "The entry was deleted."
    else
      flash[:alert] = "There was an error processing your request."
    end
    redirect_to redirection_path_for(@cv_item)
  end

  private

  def redirection_path_for(item)
    if item.education?
      profile_edit_education_path
    else
      profile_edit_work_path
    end
  end

  def cv_item_params
    params.require(:cv_item).permit(:start_month, :start_year, :end_month, :end_year,
                                    :organization_name, :position, :category)
  end
end
