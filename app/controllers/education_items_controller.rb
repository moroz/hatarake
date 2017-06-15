class EducationItemsController < CvItemsController
  expose :education_items, -> {current_user.education_items}
  expose :education_item
  expose :new_item, -> { current_candidate.education_items.new }

  def new
    render 'index'
  end

  def create
    education_item.candidate = current_candidate
    if education_item.save
      respond_to do |f|
        f.html { redirect_to education_items_path }
        f.js
      end
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
