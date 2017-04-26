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
    if !session[:return_to].blank?
      redirect_to session[:return_to]
      session[:return_to] = nil
    else
      respond_with resource, :location => after_sign_in_path_for(resource)
    end
  end

end
