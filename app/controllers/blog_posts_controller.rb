class BlogPostsController < ApplicationController
  expose(:blog_post)

  def index
    
  end

  def show

  end

  def create
    blog_post.company = current_company
    if blog_post.save
      respond_to do |f|
        f.html {  redirect_to profile_path, notice: "Post saved!" }
        f.js
      end
    else
      respond_to do |f|
        f.html { redirect_to profile_path, alert: "Post could not be saved!" }
        f.js { render_js_errors_for blog_post }
      end
    end
  end

  def edit
    @blog_post = blog_post
  end

  def update
    if blog_post.update(blog_post_params)
      redirect_to [current_company, blog_post]
    end
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:body)
  end
end
