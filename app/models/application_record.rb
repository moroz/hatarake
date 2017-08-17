class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  protected

  def add_http_to_url(url)
    if url.present?
      url.chomp!
      url = 'http://' + url unless /^https?:\/\//.match url
      url
    end
  end
end
