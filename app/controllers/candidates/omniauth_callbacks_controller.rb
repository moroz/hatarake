class Candidates::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @candidate = Candidate.from_omniauth(request.env["omniauth.auth"])
    if @candidate[1]
      sign_in_and_redirect @candidate[0], :event => :authentication
      flash[:notice] = "Sucessfully registered your account using Facebook credentials!"
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      flash[:notice] = "You are successfully signed in!"
      sign_in_and_redirect @candidate[0], :event => :authentication
    end
  end

  def failure
    redirect_to root_path
  end
end