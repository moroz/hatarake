# frozen_string_literal: true

module FindOrCreate
  extend ActiveSupport::Concern

  class_methods do
    def find_by_name(name)
      where('name_en ILIKE :q OR name_pl ILIKE :q', q: name).first
    end

    def find_or_create_by_name(name)
      where('name_en ILIKE :q OR name_pl ILIKE :q', q: name).first || create(name_en: name)
    end
  end
end
