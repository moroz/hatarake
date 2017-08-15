class AddUniqueIndexOnEmailToNewsletterSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_index :newsletter_subscriptions, :email, unique: true
  end
end
