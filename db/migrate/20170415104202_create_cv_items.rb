class CreateCvItems < ActiveRecord::Migration[5.0]
  def change
    create_table :cv_items do |t|
      t.string :type
      t.string :position
      t.date :start_date
      t.date :end_date
      t.integer :organization_id
      t.references :candidate

      t.timestamps
    end
  end
end
