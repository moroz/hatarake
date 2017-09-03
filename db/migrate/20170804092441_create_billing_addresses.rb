class CreateBillingAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :billing_addresses do |t|
      t.references :order
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :house_no
      t.string :apt_no
      t.string :postal_code
      t.string :city
      t.string :nip

      t.timestamps
    end
  end
end
