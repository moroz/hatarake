# frozen_string_literal: true

class CreateCandidateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :candidate_profiles do |t|
      t.references :user, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.date :birth_date
      t.boolean :looking_for_work
      t.references :profession, foreign_key: true

      t.timestamps
    end
  end
end
