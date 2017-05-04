class CompaniesController < ApplicationController
  before_action :find_user, only: :show
  helper_method :company

  expose :companies { Company.all }
  def index

  end

  def show
  end

  private

  def company
    @company ||= find_user
  end

  def find_user
    if params[:id].present?
      @company = User.find(params[:id])
    elsif signed_in?
      @company = current_user
    end
  end
end
