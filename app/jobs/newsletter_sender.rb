# frozen_string_literal: true

class NewsletterSender < ApplicationJob
  # Sends weekly job feeds to newsletter subscribers

  def perform
    logger.info "Sending weekly newsletter to #{NewsletterSubscription.count} subscribers"
    NewsletterSubscription.find_each do |subscriber|
      NewsletterMailer.weekly_newsletter(subscriber).deliver_later
    end
    logger.info 'Done queuing newsletters for delivery'
  end
end
