class CvItemsController < ApplicationController
  def create
    @cv_item = current_user.cv_items.new(cv_item_params)
  end

  private

  def cv_item_params
    params.require(:cv_item).permit(:start_month, :start_year, :end_month, :end_year,
                                    :organization_name, :position, :category)
  end
end
