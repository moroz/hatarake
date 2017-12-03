# frozen_string_literal: true

class ProfilesController < ApplicationController
  helper_method :company, :candidate

  def show
    return redirect_to root_path unless logged_in?
    if candidate_signed_in?
      if candidate.profile.nil?
        redirect_to edit_candidate_profile_path
      else
        render 'candidates/show'
      end
    elsif company_signed_in?
      @blog_posts = company.blog_posts.ordered
      render 'companies/show'
    end
  end

  private

  def company
    current_company
  end

  def candidate
    current_candidate
  end
end
