class WorkItemsController < CvItemsController
  expose :work_item
  expose :work_items, -> {current_user.work_items}

  def create
    work_item.candidate = current_user
    if work_item.save
      redirect_to work_items_path
    else
      respond_to do |f|
        f.html do
          render 'index'
        end
        f.js { render_js_errors_for work_item }
      end
    end
  end

  def destroy
    if work_item.destroy
      flash[:success] = I18n.t('cv_items.destroy.success')
    else
      flash[:alert] = I18n.t('errors.generic')
    end
    redirect_to work_items_path
  end

  private

  def work_item_params
    params.require(:work_item).permit(:start_date, :end_date, :organization, :position, :category)
  end
end
