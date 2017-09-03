class AddPremiumServicesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :premium_services, :hstore
  end
end
