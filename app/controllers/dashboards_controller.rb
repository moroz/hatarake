class DashboardsController < ApplicationController
  def show
    unless signed_in?
      redirect_to root_path and return
    end
    if candidate_signed_in?
      candidate_dashboard
    elsif company_signed_in?
      company_dashboard
    end
  end

  private

  def candidate_dashboard
    @saved = current_candidate.saved_offers.includes(location: [:country])
    @applied = current_candidate.applied_offers.includes(location: [:country])
    render 'candidate_dashboard'
  end

  def company_dashboard
    @offers = current_company.offers.limit(12)
    @applications = current_company.applications.includes(:offer).unread.group_by(&:offer)
    render 'company_dashboard'
  end

end
