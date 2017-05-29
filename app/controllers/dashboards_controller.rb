class DashboardsController < ApplicationController
  def show
    unless signed_in?
      redirect_to root_path and return
    end
    if candidate_signed_in?
      candidate_dashboard
    elsif company_signed_in?
      company_dashboard
    elsif admin_signed_in?
      admin_dashboard
    end
  end

  private

  def candidate_dashboard
    @saved = current_candidate.saved_offers
    @applied = current_candidate.applied_offers
    render 'candidate_dashboard'
  end

  def company_dashboard
    render 'company_dashboard'
  end

  def admin_dashboard
  end

end
