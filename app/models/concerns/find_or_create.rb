module FindOrCreate
  extend ActiveSupport::Concern

  def find_by_name(name)
    self.where("name ILIKE :q OR name_pl ILIKE :q", q:name).first
  end

  def find_or_create_by_name(name)
    self.where("name ILIKE :q OR name_pl ILIKE :q", q:name).first || create(name: name)
  end
end
