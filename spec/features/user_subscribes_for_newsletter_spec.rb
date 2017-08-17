require 'rails_helper'

RSpec.describe 'User subscribes for newsletter' do
  describe 'subscribing' do
    context 'when valid e-mail is input in the subscription form' do
      it 'creates new NewsletterSubscription instance' do
        visit new_newsletter_subscription_path
        find('input[name="newsletter_subscription[email]"]').set('user@example.com')
        expect { submit_form }.to change { NewsletterSubscription.count }
      end
    end
  end

  describe 'unsubscribing' do
    before do
      NewsletterSubscription.create(email: 'user@example.com', name: 'Example User')
    end

    context 'when e-mail present in the DB is input in unsubscription form' do
      it 'changes NewsletterSubscription count' do
        visit unsubscribe_path
        find('input[name="newsletter_subscription[email]"]').set('user')
      end
    end

    context 'when non-existent e-mail is input' do
      it "doesn't change NewsletterSubscription count" do

      end
    end
  end
end
