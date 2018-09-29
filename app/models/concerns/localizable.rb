# frozen_string_literal: true

module Localizable
  extend ActiveSupport::Concern

  class_methods do
    def local_order
      if I18n.locale == :pl
        order('name_pl, name_en')
      else
        order(:name_en)
      end
    end

    def find_by_local_name(name)
      where('name_en = :name OR name_pl = :name', name: name).first
    end
  end

  def local_name
    if I18n.locale == :pl
      name_pl
    else
      name_en
    end
  end

  def local_description
    return unless respond_to?(:description_en)
    if I18n.locale == :pl
      description_pl
    else
      description_en
    end
  end

  def name_pl
    super || name_en
  end
end
