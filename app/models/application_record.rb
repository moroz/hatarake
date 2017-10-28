class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :random_order, -> { reorder('RANDOM()') }

  protected

  def add_http_to_url(url)
    if url.present?
      url.chomp!
      url = 'http://' + url unless /^https?:\/\//.match url
      url
    end
  end

  private

  def net_price(price)
    (price * (100.0/(100+23))).round(2)
  end
end
