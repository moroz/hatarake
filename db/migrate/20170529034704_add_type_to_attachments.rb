# frozen_string_literal: true

class AddTypeToAttachments < ActiveRecord::Migration[5.0]
  def change
    add_column :attachments, :type, :string
  end
end
