class AttachmentsController < ApplicationController
  authorize_resource

  def new
    @attachment = current_user.attachments.new
  end

  def create
    @attachment = current_user.attachments.new(attachment_params)
    if @attachment.save
      redirect_to profile_path, notice: "Success"
    end
  end

  private

  def attachment_params
    params.require(:attachment).permit(:file)
  end
end
