class Skill < ApplicationRecord
  has_many :skills

  def self.find_or_create_by_name(name)
    self.where("name = :q OR name_pl = :q", q:name).first || create(name: name)
  end
end
