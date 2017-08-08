class ResumesController < ApplicationController
  helper_method :resume
  authorize_resource

  def create
    @resume = current_user.resumes.new(resume_params)
    @resume.filename = "CV-#{current_user.display_name}-#{SecureRandom.hex(2)}".gsub(/\s/, '-')
    if @resume.save
      redirect_to profile_path, notice: I18n.t("resumes.create.success")
    else
      respond_to do |f|
        f.html do
          raise ActionController::BadRequest.new, "File could not be saved"
        end
        f.js { render_js_errors_for @resume }
      end
    end
  end

  def destroy
    @resume = Resume.find(params[:id])
    if @resume.destroy
      redirect_to profile_path, notice: I18n.t('resumes.destroy.success')
    end
  end

  private

  def resume_params
    params.require(:resume).permit(:file, :description, :language)
  end
end
