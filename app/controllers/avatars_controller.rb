class AvatarsController < ApplicationController
  authorize_resource
  helper_method :avatar

  def new
    @avatar = current_user.avatar || current_user.build_avatar
  end

  def show; end

  def crop; end

  def create
    @avatar = current_user.build_avatar(avatar_params)
    if @avatar.save
      if params[:avatar][:file].present? && avatar.croppable?
        redirect_to crop_avatar_path
      else
        redirect_to profile_path, notice: I18n.t('avatars.success')
      end
    else
      respond_to do |f|
        f.html { redirect_to edit_avatar_path }
        f.js { render_js_errors_for(@avatar) }
      end
    end
  end

  def update
    @avatar = current_user.avatar
    if @avatar.update(avatar_params)
      if params[:avatar][:file].present? && avatar.croppable?
        redirect_to crop_avatar_path
      else
        redirect_to profile_path, notice: I18n.t('avatars.success')
      end
    else
      respond_to do |f|
        f.html { redirect_to edit_avatar_path, warning: 'Failure' }
        f.js { render_js_errors_for(@avatar) }
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

