# frozen_string_literal: true

class PagesController < ApplicationController
  def sign_up
    deny_access_if_logged_in
  end
end
