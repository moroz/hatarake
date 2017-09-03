class CreateProfessions < ActiveRecord::Migration[5.0]
  def change
    create_table :professions do |t|
      t.string :name
      t.string :name_pl

      t.timestamps
    end
  end
end
