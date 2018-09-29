# frozen_string_literal: true

class DashboardsController < ApplicationController
  def show
    redirect_to(root_path) && return unless logged_in?
    if candidate_signed_in?
      candidate_dashboard
    elsif company_signed_in?
      company_dashboard
    end
  end

  private

  def candidate_dashboard
    @applied = current_candidate.applied_offers.includes(locations: %i[country province], company: [:avatar])
    @saved_offers = OfferSave.where(user_id: current_user).joins(:offer).distinct
    render 'candidate_dashboard'
  end

  def company_dashboard
    @stats = {
      offer_count: current_company.offers.count,
      published_offer_count: current_company.offers.published.count,
      unpaid_orders_count: current_company.orders.unpaid.count
    }
    render 'company_dashboard'
  end
end
