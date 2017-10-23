# frozen_string_literal: true

class AddPublishedOffersCountToUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :published_offers_count, :integer, default: 0
    con = ActiveRecord::Base.connection
    con.execute(%{UPDATE users AS u SET published_offers_count = cnt FROM (
    SELECT u.id AS users_id, COUNT(o.id) AS cnt FROM users AS u LEFT JOIN offers o
    ON u.id = o.company_id AND o.published_at IS NOT NULL GROUP BY u.id) AS subquery
                WHERE u.id = users_id})
  end

  def down
    remove_column :users, :published_offers_count, :integer
  end
end
