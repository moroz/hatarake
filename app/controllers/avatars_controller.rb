class AvatarsController < ApplicationController
  authorize_resource
  helper_method :avatar

  rescue_from CarrierWave::IntegrityError do
    redirect_to edit_avatar_path, alert: I18n.t('avatars.integrity_error_message')
  end

  def show
  end

  def crop
  end

  def create
    if avatar.update(avatar_params)
      if params[:avatar][:file].present? && avatar.croppable?
        redirect_to crop_avatar_path
      else
        redirect_to profile_path, notice: I18n.t('avatars.success')
      end
    end
  end


  def update
    if avatar.update(avatar_params)
      if params[:avatar][:file].present? && avatar.croppable?
        redirect_to crop_avatar_path
      else
        redirect_to profile_path, notice: I18n.t('avatars.success')
      end
    end
  end

  def avatar
    @avatar ||= current_user.avatar || current_user.build_avatar
  end

  private

  def avatar_params
    params.require(:avatar).permit(%i{file crop_x crop_y crop_w crop_h})
  end
end

