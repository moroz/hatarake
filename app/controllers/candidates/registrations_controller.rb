class Candidates::RegistrationsController < Devise::RegistrationsController

  def new
    if logged_in?
      redirect_to root_path, alert: I18n.t('devise.failure.already_authenticated') and return
    end
    super
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  def after_sign_up_path_for(resource)
    edit_candidate_profile_path
  end

end
