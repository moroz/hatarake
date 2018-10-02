# frozen_string_literal: true

class CreateRawPaymentsData < ActiveRecord::Migration[5.1]
  def change
    create_table :raw_payments_data do |t|
      t.text :data
    end
  end
end
