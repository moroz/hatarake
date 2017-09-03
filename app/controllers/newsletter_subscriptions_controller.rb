class NewsletterSubscriptionsController < ApplicationController
  def create
    @subscription = NewsletterSubscription.new(subscription_params)
    if @subscription.save
      redirect_to root_path, notice: "You have successfully subscribed to our newsletter." 
    else
      respond_to do |f|
        f.html { render :new }
        f.js { render_js_errors_for @subscription }
      end
    end
  end

  def unsubscribe
  end

  def destroy
    @subscription = NewsletterSubscription.find_by(email: params[:email])
    if @subscription.present?
      @subscription.destroy
      redirect_to root_path, notice: 'Your e-mail has been removed from our database.'
    else
      redirect_to unsubscribe_path, alert: 'This e-mail address does not exist in our database.'
    end
  end

  private

  def subscription_params
    params.require(:newsletter_subscription).permit(:name, :email)
  end
end
