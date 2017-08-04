class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :disable_turbolinks, only: [:new, :edit, :create, :update]
  helper_method :current_user, :current_locale, :local_name, :page_title, :logged_in?, :translate_with_gender, :current_cart

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end

  def current_user
    super || current_candidate || current_company || current_admin_user
  end

  def logged_in?
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

  def current_cart
    return unless logged_in?
    current_user.carts.unfinalized.first || current_user.carts.create
  end

  private

  def disable_turbolinks
    @disable_turbolinks = true
  end

  def set_locale
    if params[:lang].present?
      session[:locale] = params[:lang] 
      if logged_in?
        current_user.set_locale(params[:lang])
      end
    end
    I18n.locale = session[:locale] || user_locale || accepted_language || I18n.default_locale
  end

  def set_admin_locale
    I18n.locale = :en
  end

  def user_locale
    current_user.try(:locale)
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

  def deny_access_if_logged_in
    if logged_in?
      redirect_to root_path, alert: I18n.t('devise.failure.already_authenticated') and return
    end
  end

  def set_country_list
    @countries = Country.order(local_name)
  end
end
