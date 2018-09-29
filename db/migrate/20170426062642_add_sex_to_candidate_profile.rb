# frozen_string_literal: true

class AddSexToCandidateProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :candidate_profiles, :sex, :integer, limit: 2, comment: 'ISO/IEC 5218-compliant
               sex field, 1 male, 2 female'
  end
end
