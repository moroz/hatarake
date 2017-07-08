class ProfilesController < ApplicationController
  helper_method :company, :candidate

  def show
    unless logged_in?
      redirect_to root_path and return
    end
    if candidate_signed_in?
      if candidate.profile.nil?
        redirect_to edit_candidate_profile_path
      else
        render 'candidates/show'
      end
    elsif company_signed_in?
      @rating = company.reputation_for(:avg_rating).round(2)
      @ratings_count = company.ratings_count
      render 'companies/show'
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
