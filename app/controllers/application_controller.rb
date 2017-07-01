class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :disable_turbolinks, only: [:new, :edit, :create, :update]
  helper_method :current_user, :admin_signed_in?, :current_locale, :local_name, :page_title, :signed_in?, :translate_with_gender

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end

  def current_user
    super || current_candidate || current_company
  end

  def signed_in?
    !!current_user
  end

  def current_locale
    I18n.locale
  end

  def local_name
    "name_#{current_locale}".to_sym
  end

  def translate_with_gender(key, gender = 'male')
    I18n.t(key + ".#{gender}")
  end

  def page_title
    if @title.present?
      @title + " – " + I18n.t('default_title')
    else
      I18n.t('.title', default: :default_title)
    end
  end

  private

  def disable_turbolinks
    @disable_turbolinks = true
  end

  def set_locale
    session[:locale] = params[:lang] if params[:lang].present?
    I18n.locale = session[:locale] || accepted_language || I18n.default_locale
  end

  def set_admin_locale
    I18n.locale = :en
  end

  def accepted_language
    return if request.env['HTTP_ACCEPT_LANGUAGE'].blank?
    /pl/ =~ request.env['HTTP_ACCEPT_LANGUAGE'] ? :pl : :en
  end

  def current_user_is_a?(type)
    current_user && current_user.type == type
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:first_name, :last_name])
  end

  def render_js_errors_for(object)
    @object = object
    render 'errors'
  end
end
