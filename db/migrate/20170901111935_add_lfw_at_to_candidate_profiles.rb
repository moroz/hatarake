# frozen_string_literal: true

class AddLfwAtToCandidateProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :candidate_profiles, :lfw_at, :timestamp
  end
end
