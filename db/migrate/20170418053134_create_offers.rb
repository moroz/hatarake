class CreateOffers < ActiveRecord::Migration[5.0]
  def change
    create_table :offers do |t|
      t.references :company, references: :users
      t.integer :salary_min
      t.integer :salary_max
      t.string :currency
      t.string :contact_email
      t.string :contact_phone
      t.text :description

      t.timestamps
    end
  end
end
