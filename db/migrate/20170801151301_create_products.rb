class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name_pl
      t.string :name_en
      t.decimal :price_pln, precision: 8, scale: 2
      t.decimal :price_eur, precision: 8, scale: 2

      t.timestamps
    end
  end
end
