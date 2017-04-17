class AvatarsController < ApplicationController
  def new
    @avatar = Avatar.new
  end

  def create
    @avatar = current_user.avatar || current_user.build_avatar
    if @avatar.update(avatar_params)
      flash[:success] = "The new avatar has been uploaded."
    else
      flash[:alert] = "There was an error processing your request."
    end
    redirect_to new_avatar_path
  end

  private

  def avatar_params
    params.require(:avatar).permit(:image)
  end
end
