# frozen_string_literal: true

class AddProfessionNameToCandidateProfiles < ActiveRecord::Migration[5.1]
  def up
    add_column :candidate_profiles, :profession_name, :string
    conn = ActiveRecord::Base.connection
    conn.execute(%(UPDATE candidate_profiles cp SET profession_name = p.name_en FROM
                  users u, professions p WHERE u.id = cp.user_id AND p.id = u.profession_id))
  end

  def down
    remove_column :candidate_profiles, :profession_name, :string
  end
end
