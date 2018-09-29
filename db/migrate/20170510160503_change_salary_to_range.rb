# frozen_string_literal: true

class ChangeSalaryToRange < ActiveRecord::Migration[5.0]
  def up
    add_column :offers, :salary, :numrange
    execute("UPDATE offers SET salary = numrange(salary_min, salary_max, '[]')")
    remove_column :offers, :salary_min
    remove_column :offers, :salary_max
  end

  def down
    change_table :offers do |t|
      t.integer :salary_min
      t.integer :salary_max
    end
    execute(%{UPDATE offers SET salary_min = lower(salary), salary_max = upper(salary)})
    remove_column :offers, :salary
  end
end
