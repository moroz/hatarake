class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  helper_method :current_user, :admin?, :current_locale, :local_name, :page_title

  def admin?
    current_user_is_a?("Admin")
  end

  def current_user
    super || current_candidate || current_company
  end

  def current_locale
    I18n.locale
  end

  def local_name
    "name_#{current_locale}".to_sym
  end

  def page_title
    @title || I18n.t('.title', default: :default_title)
  end

  private

  def set_locale
    session[:locale] = params[:lang] if params[:lang].present?
    I18n.locale = session[:locale] || I18n.default_locale
  end

  def current_user_is_a?(type)
    current_user && current_user.type == type
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:first_name, :last_name])
  end
end
