class AddLookingForWorkToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :looking_for_work, :boolean, default: false
  end
end
