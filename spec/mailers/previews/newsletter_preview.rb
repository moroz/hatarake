class NewsletterPreview < ActionMailer::Preview
  def weekly_newsletter
    recipient = NewsletterSubscription.last || NewsletterSubscription.create(name: 'Example User', email: 'user@example.com')
    NewsletterMailer.weekly_newsletter(recipient)
  end
end
