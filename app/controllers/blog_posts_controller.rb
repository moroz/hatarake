# frozen_string_literal: true

class BlogPostsController < ApplicationController
  respond_to :html, :js
  expose(:blog_post)
  expose(:company)

  invisible_captcha only: %i[create update]

  def index
    @blog_posts = company.blog_posts.order(updated_at: :desc)
  end

  def show; end

  def create
    blog_post.company = current_company
    if blog_post.save
      respond_to do |f|
        f.html { redirect_to profile_path, notice: 'Post saved!' }
        f.js
      end
    else
      respond_to do |f|
        f.html { redirect_to profile_path, alert: 'Post could not be saved!' }
        f.js { render_js_errors_for blog_post }
      end
    end
  end

  def destroy
    @post_id = blog_post.id
    return unless blog_post.destroy
    respond_to do |f|
      f.html { redirect_to profile_path, notice: 'Post deleted!' }
      f.js
    end
  end

  def edit
    @blog_post = blog_post
  end

  def update
    return unless blog_post.update(blog_post_params)
    respond_to do |f|
      f.js
      f.html { redirect_to [current_company, blog_post] }
    end
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:body)
  end
end
