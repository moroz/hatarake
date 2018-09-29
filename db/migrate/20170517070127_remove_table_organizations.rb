# frozen_string_literal: true

class RemoveTableOrganizations < ActiveRecord::Migration[5.0]
  def up
    add_column :education_items, :organization, :string
    execute('UPDATE education_items AS e SET organization = o.name_en FROM
             organizations AS o WHERE e.organization_id = o.id')
    add_column :work_items, :organization, :string
    execute('UPDATE work_items AS w SET organization = o.name_en FROM organizations AS o WHERE
             w.organization_id = o.id')
    remove_column :education_items, :organization_id
    remove_column :work_items, :organization_id
    drop_table :organizations
  end

  # Too much hassle, let's just make it irreversible
  # def down
  # create_table :organizations do |t|
  # t.string :name_en
  # t.string :name_pl
  # t.timestamps
  # end
  # add_column :education_items, :organization_id, :integer
  # add_column :work_items, :organization_id, :integer
  # end
end
