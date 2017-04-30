module Localizable
  extend ActiveSupport::Concern

  def self.local_order
    if I18n.locale == :pl
      order('name_pl, name_en')
    else
      order(:name_en)
    end
  end

  def local_name
    if I18n.locale == :pl
      name_pl
    else
      name_en
    end
  end

  def name_pl
    super || name_en
  end
end
