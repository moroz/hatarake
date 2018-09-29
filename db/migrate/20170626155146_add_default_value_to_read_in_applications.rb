# frozen_string_literal: true

class AddDefaultValueToReadInApplications < ActiveRecord::Migration[5.0]
  def up
    change_column :applications, :read, :boolean, default: false
  end

  def down
    change_column :applications, :read, :boolean, default: nil
  end
end
