class SessionsController < Devise::SessionsController

  def new
    if params[:return_to].present?
      session[:return_to] = params[:return_to]
    end
    super
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    scope = resource.type.downcase.to_sym
    sign_in(scope, resource)
    # HACK: This code should be deleted in future when users will be noticed about RODO
    if resource.last_sign_in_at.round == resource.current_sign_in_at.round
      cookies['cookie_eu_consented'] = false
    end
    respond_with resource, :location => after_sign_in_path_for(resource)
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    respond_to_on_destroy
  end

  private

  def after_sign_in_path_for(resource)
    session.delete(:return_to) ||
    case resource.type
      when "Candidate"
        return resource.not_updated_profile? ? edit_candidate_profile_path(ref: 'signup')
          : dashboard_path
      when "Company"
        dashboard_path
      else
        super(resource)
    end
  end
end
