class ResumesController < ApplicationController
  helper_method :resume
  authorize_resource

  def new

  end

  def create
    if resume.save
      redirect_to profile_path, notice: "Success"
    else
      respond_to do |f|
        f.html do
          flash.now.alert = "There was an error processing your request."
          render 'new'
        end
        f.js { render_js_errors_for resume }
      end
    end
  end

  private

  def resume
    @resume ||= current_candidate.resumes.new(resume_params)
  end

  def resume_params
    params.require(:resume).permit(:file, :description, :language)
  end
end
