# frozen_string_literal: true

class Candidates::RegistrationsController < Devise::RegistrationsController
  invisible_captcha only: :create
  before_action :configure_sign_up_params, if: :devise_controller?, only: :create

  def new
    redirect_to(root_path, alert: I18n.t('devise.failure.already_authenticated')) && return if logged_in?
    session[:return_to] = params[:return_to] if params[:return_to].present?
    # Override Devise default behaviour and create profile build as well
    build_resource({})
    resource.build_profile
    respond_with resource
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer
      .permit(:sign_up, keys:
        [:attribute, :terms_of_service, :personal_data, :rodo, profile_attributes: %i[first_name last_name]])
  end

  def after_sign_up_path_for(_resource)
    edit_candidate_profile_path
  end

  def after_sign_in_path_for(_resource)
    dashboard_path
  end
end
