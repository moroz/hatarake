# frozen_string_literal: true

class AddUniqueIndexOnBodyToBlogPosts < ActiveRecord::Migration[5.1]
  def change
    add_index :blog_posts, %i[user_id body], unique: true
  end
end
