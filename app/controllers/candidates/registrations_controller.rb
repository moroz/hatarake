class Candidates::RegistrationsController < Devise::RegistrationsController
  invisible_captcha only: :create
  before_action :configure_sign_up_params, if: :devise_controller?, only: :create

  def new
    if logged_in?
      redirect_to root_path, alert: I18n.t('devise.failure.already_authenticated') and return
    end
    if params[:return_to].present?
      session[:return_to] = params[:return_to]
    end
    # Override Devise default behaviour and create profile build as well
    build_resource({})
    resource.build_profile
    respond_with self.resource
  end

  def create
    super
    if resource.save
      @profile = Profile.new(resource)
      @profile.first_name = sign_up_params["profile_attributes"]["first_name"]
      @profile.last_name = sign_up_params["profile_attributes"]["last_name"]
      @profile.save!(:validate => false)
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer
      .permit(:sign_up, keys: [:attribute, :terms_of_service, :personal_data, profile_attributes: [:first_name, :last_name] ])
  end

  def after_sign_up_path_for(resource)
    edit_candidate_profile_path
  end

  def after_sign_in_path_for(resource)
    dashboard_path
  end

end
