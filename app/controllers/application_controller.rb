class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_user, :admin?, :company?, :candidate?

  #def after_sign_in_path_for(resource)
    #profile_path
  #end
  def current_user
    super || current_candidate || current_company
  end

  def admin?
    current_user_is_a? "Admin"
  end

  def company?
    current_user_is_a? "Company"
  end

  def candidate?
    current_user_is_a? "Candidate"
  end

  private

  def current_user_is_a?(type)
    current_user && current_user.type == type
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:first_name, :last_name])
  end
end
