# frozen_string_literal: true

class AllowNullInUsersContactEmail < ActiveRecord::Migration[5.0]
  def up
    remove_index :users, :contact_email
    add_index :users, :contact_email
  end

  def down
    remove_index :users, :contact_email
    add_index :users, :contact_email, unique: true
  end
end
