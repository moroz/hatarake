# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :random_order, -> { reorder('RANDOM()') }

  protected

  def add_http_to_url(url)
    return unless url.present?
    url.chomp!
    url = 'http://' + url unless /^https?:\/\//.match url
    url
  end
end
