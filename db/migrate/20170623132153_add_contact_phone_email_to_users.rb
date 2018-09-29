# frozen_string_literal: true

class AddContactPhoneEmailToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :phone, :string
    add_column :users, :contact_email, :string

    add_index :users, :contact_email, unique: true
  end
end
