class WorkItemsController < CvItemsController
  expose :work_item
  expose :work_items, -> {current_user.work_items}

  def create
    work_item.candidate = current_user
    if work_item.save
      redirect_to work_items_path
    else
      @work_item = work_item
      render :index
    end
  end

  def destroy
    if work_item.destroy
      flash[:success] = "The entry was deleted."
    else
      flash[:alert] = "There was an error processing your request."
    end
    redirect_to work_items_path
  end

  private

  def work_item_params
    params.require(:work_item).permit(:start_date, :end_date, :organization, :position, :category)
  end
end
