class ResumesController < ApplicationController
  def new

  end

  def create
    if resume.save
      redirect_to profile_path, notice: "Success"
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
