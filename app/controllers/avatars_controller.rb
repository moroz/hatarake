class AvatarsController < ApplicationController
  def new
    @avatar = Avatar.new
    @avatar.user = current_user
  end

  def create
    @avatar = current_user.build_avatar(avatar_params)
    if @avatar.save
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
