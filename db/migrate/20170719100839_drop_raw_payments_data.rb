# frozen_string_literal: true

class DropRawPaymentsData < ActiveRecord::Migration[5.1]
  def change
    drop_table :raw_payments_data
  end
end
