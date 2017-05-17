class CompaniesController < ApplicationController
  before_action :find_user, only: :show
  helper_method :company

  expose :companies { Company.all }
  authorize_resource
  def index

  end

  def edit
    if company_signed_in?
      @company = current_company
    else
      redirect_to root_path
    end
  end

  def show
    if request.path != company_path(company)
      redirect_to company, status: :moved_permanently
    end
  end

  def update
    company = current_company
    if company.update(company_params)
      redirect_to company
    else
      respond_to do |f|
        f.html {
          flash.alert = "The profile could not be saved."
        }
        f.js { render_js_errors_for company }
      end
    end
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

  def company_params
    params.require(:company).permit(:name, :website, :description)
  end
end
