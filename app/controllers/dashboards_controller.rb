class DashboardsController < ApplicationController
  def show
    unless logged_in?
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
    @saved = current_candidate.saved_offers.includes(location: [:country, :province], company: [:avatar])
    @applied = current_candidate.applied_offers.includes(location: [:country, :province], company: [:avatar])
    render 'candidate_dashboard'
  end

  def company_dashboard
    @offers = current_company.offers.includes(location: [:country, :province]).limit(12)
    @applications = current_company.applications.includes(:offer).unread.group_by(&:offer)
    render 'company_dashboard'
  end

end
