class AddDurationRenameValidThruInSubscriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :subscriptions, :duration, :integer, default: 2592000
    add_column :subscriptions, :price, :decimal, precision: 8, scale: 2
    rename_column :subscriptions, :valid_thru, :valid_until
  end
end
