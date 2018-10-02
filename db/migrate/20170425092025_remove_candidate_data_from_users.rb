# frozen_string_literal: true

class RemoveCandidateDataFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
    remove_column :users, :birth_date, :date
    remove_column :users, :looking_for_work, :boolean
  end
end
