# frozen_string_literal: true

class HomeController < ApplicationController
  layout 'home'

  def home
    @offers = Offer.includes(company: :avatar, location: [:country]).homepage_featured.random_order.limit(20)
    @companies = Company.includes(:avatar).featured.random_order
  end
end
