class AddUniqueIndexOnBodyToBlogPosts < ActiveRecord::Migration[5.1]
  def change
    add_index :blog_posts, [:user_id, :body], unique: true
  end
end
