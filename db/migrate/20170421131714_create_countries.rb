class CreateCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :countries do |t|
      t.string :iso
      t.string :name_pl
      t.string :name_en

      t.timestamps
    end
  end
end
