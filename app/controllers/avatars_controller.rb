class AvatarsController < ApplicationController
  authorize_resource
  helper_method :avatar

  def new
  end

  def create
    if avatar.update(avatar_params)
      redirect_to profile_path, notice: "Success"
    end
  end

  def avatar
    @avatar = current_user.avatar || current_user.build_avatar
  end

  private

  def avatar_params
    params.require(:avatar).permit(:file)
  end
end

