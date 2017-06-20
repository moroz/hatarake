class AvatarsController < ApplicationController
  authorize_resource
  helper_method :avatar

  def show
  end

  def update
    if avatar.update(avatar_params)
      if params[:avatar][:file].present?
        render :crop
      else
        redirect_to profile_path, notice: "Success"
      end
    end
  end

  def avatar
    @avatar = current_user.avatar || current_user.build_avatar
  end

  private

  def avatar_params
    params.require(:avatar).permit(%i{file crop_x crop_y crop_w crop_h})
  end
end

