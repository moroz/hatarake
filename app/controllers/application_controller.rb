class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  #def after_sign_in_path_for(resource)
    #profile_path
  #end

  private

  def current_user
    super || current_candidate || current_company
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:first_name, :last_name])
  end
end
