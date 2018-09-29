# frozen_string_literal: true

class RemoveProfessionFromCandidateProfiles < ActiveRecord::Migration[5.0]
  def change
    remove_reference :candidate_profiles, :profession, foreign_key: true
  end
end
