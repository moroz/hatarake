class BlogPostsController < ApplicationController
  expose(:blog_post)

  def index
    
  end

  def create
    blog_post.company = current_company
    if blog_post.save
      redirect_to profile_path, notice: "Post saved!"
    end
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:body)
  end
end