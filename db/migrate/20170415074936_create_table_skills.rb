class CreateTableSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :skills do |t|
      t.string :name
      t.string :name_pl

      t.timestamps
    end
  end
end
