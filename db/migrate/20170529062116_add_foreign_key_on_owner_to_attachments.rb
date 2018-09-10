# frozen_string_literal: true

class AddForeignKeyOnOwnerToAttachments < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :attachments, :users, column: 'owner_id'
  end
end
