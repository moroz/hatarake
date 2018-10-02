# frozen_string_literal: true

class AddPremiumOptionsToOffers < ActiveRecord::Migration[5.1]
  def change
    change_table :offers do |t|
      t.column :featured_until, :timestamp, comment: 'Featuring on the homepage'
      t.column :category_until, :timestamp, comment: 'Featuring on the category page'
      t.column :highlight_until, :timestamp, comment: 'Highlight with colors'
    end
  end
end
