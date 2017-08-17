class CreateJoinTableCompaniesFields < ActiveRecord::Migration[5.0]
  def change
    create_join_table :companies, :fields do |t|
      t.index [:company_id, :field_id]
    end
  end
end
