class CreateBlogPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :blog_posts do |t|
      t.references :user, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
