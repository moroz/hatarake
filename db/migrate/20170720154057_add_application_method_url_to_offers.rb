class AddApplicationMethodUrlToOffers < ActiveRecord::Migration[5.1]
  def change
    add_column :offers, :apply_on_website, :boolean, default: false
    add_column :offers, :application_url, :string
  end
end
