class EducationItemsController < CvItemsController
  expose :education_items, -> {current_user.education_items}
  expose :education_item

  def create
    education_item.candidate = current_candidate
    if education_item.save
      redirect_to education_items_path
    else
      respond_to do |f|
        f.html do
          render 'index'
        end
        f.js { render_js_errors_for education_item }
      end
    end
  end

  def destroy
    if education_item.destroy
      flash[:success] = I18n.t('cv_items.destroy.success')
    else
      flash[:alert] = I18n.t('errors.generic')
    end
    redirect_to education_items_path
  end
  
  private

  def education_item_params
    params.require(:education_item).permit(:start_date, :end_date,
                         :organization, :specialization, :category)
  end
end
