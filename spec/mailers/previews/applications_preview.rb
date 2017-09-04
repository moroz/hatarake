# Preview all emails at http://localhost:3000/rails/mailers/applications
class ApplicationsPreview < ActionMailer::Preview
  def new_application
    application = Application.where('memo != ?', '').last
    ApplicationsMailer.new_application(application)
  end

end
