# frozen_string_literal: true

class AddHourlyWageToOffers < ActiveRecord::Migration[5.0]
  def change
    add_column :offers, :hourly_wage, :numrange
  end
end
