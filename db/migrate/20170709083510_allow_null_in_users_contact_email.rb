class AllowNullInUsersContactEmail < ActiveRecord::Migration[5.0]
  def up
    remove_index :users, :contact_email
    add_index :users, :contact_email, unique: true, where: 'contact_email IS NOT NULL'
  end

  def down
    remove_index :users, :contact_email
    add_index :users, :contact_email, unique: true
  end
end
