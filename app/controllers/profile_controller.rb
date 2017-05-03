class ProfileController < ApplicationController
  helper_method :company, :candidate

  def profile
    unless signed_in?
      redirect_to root_path and return
    end
    if candidate_signed_in?
      render 'candidates/show'
    elsif company_signed_in?
      render 'companies/show'
    elsif admin?
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
