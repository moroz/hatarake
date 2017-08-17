class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!

  private

  def authenticate_admin!
    raise CanCan::AccessDenied unless admin_user_signed_in?
  end
end
