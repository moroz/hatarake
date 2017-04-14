class ProfileController < ApplicationController
  def show
    if params[:id].present?
      @user = User.find(params[:id])
    elsif signed_in?
      @user = current_candidate || current_company
    else
      flash[:alert] = "Your request could not be processed."
      redirect_to root_path
    end
    @skills = @user.skills
  end

  def contact_data
  end

  def languages
  end
end
