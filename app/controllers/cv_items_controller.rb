# frozen_string_literal: true

class CvItemsController < ApplicationController
  def index
    @hide_breadcrumbs = true
  end
end
