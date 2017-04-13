class DropTablesCandidatesEmployers < ActiveRecord::Migration[5.0]
  def change
    drop_table :candidates
    drop_table :employers
  end
end
