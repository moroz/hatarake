# frozen_string_literal: true

class Candidates::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @candidate = Candidate.from_omniauth(request.env['omniauth.auth'])
    if @candidate[0].company?
      flash[:alert] = 'There is a company account registered with this email - try to log in using your email!'
      redirect_to(new_company_session_path) && return
    end
    if @candidate[1]
      sign_in_and_redirect @candidate[0], event: :authentication
      flash[:notice] = 'Sucessfully registered your account using Facebook credentials!'
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      flash[:notice] = 'You are successfully signed in!'
      sign_in_and_redirect @candidate[0], event: :authentication
    end
  end

  def failure
    redirect_to new_user_session_path
  end
end
