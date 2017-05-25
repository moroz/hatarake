class SessionsController < Devise::SessionsController

  def new
    super
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    scope = case resource.type
            when "Company"
              :company
            when "Candidate"
              :candidate
            else
              :user
            end
    sign_in(scope, resource)
    if session[:return_to].present?
      redirect_to session[:return_to]
      session[:return_to] = nil
    else
      respond_with resource, :location => after_sign_in_path_for(resource)
    end
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    respond_to_on_destroy
  end

  private

  def after_sign_in_path_for(resource)
    case resource.type
      when "Candidate"
        return resource.profile.present? ? candidate_dashboard_path
          : candidate_step2_path
      else
        super(resource)
    end
  end
end
