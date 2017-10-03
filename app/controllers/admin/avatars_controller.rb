# frozen_string_literal: true

class Admin::AvatarsController < Admin::BaseController
  expose :company, -> { Company.friendly.find(params[:id] || avatar_params[:owner_id]) }
  expose :avatar, -> { company.avatar || company.build_avatar }

  def new
    render 'avatars/new'
  end

  def create
    @avatar = company.build_avatar(avatar_params)
    if @avatar.save
      if params[:avatar][:file].present? && @avatar.croppable?
        redirect_to crop_admin_avatar_path(id: company.to_param)
      else
        redirect_to admin_company_path(company), notice: I18n.t('avatars.success')
      end
    else
      respond_to do |f|
        f.html { redirect_to edit_admin_avatar_path(id: company.to_param) }
        f.js { render_js_errors_for(avatar) }
      end
    end
  end

  def update
    if avatar.update(avatar_params)
      if params[:avatar][:file].present? && avatar.croppable?
        redirect_to crop_admin_avatar_path(id: company.to_param)
      else
        redirect_to admin_company_path(company), notice: I18n.t('avatars.success')
      end
    else
      respond_to do |f|
        f.html { redirect_to edit_admin_avatar_path(id: company.to_param), warning: "Wystąpił błąd" }
        f.js { render_js_errors_for(avatar) }
      end
    end
  end

  def crop
    render 'avatars/crop'
  end

  private

  def avatar_params
    params.require(:avatar).permit(%i[file crop_x crop_y crop_w crop_h owner_id])
  end
end
