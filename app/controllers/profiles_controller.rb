class ProfilesController < ApplicationController
  helper_method :company, :candidate

  def show
    unless signed_in?
      redirect_to root_path and return
    end
    if candidate_signed_in?
      if candidate.profile.nil?
        redirect_to edit_candidate_profile_path
      else
        render 'candidates/show'
      end
    elsif company_signed_in?
      render 'companies/show'
    elsif admin_signed_in?
      redirect_to root_path # This will be dashboard later
    end
  end

  private

  def company
    current_company
  end

  def candidate
    current_candidate
  end
end
