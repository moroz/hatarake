# frozen_string_literal: true

class AddSocialUntilToOffer < ActiveRecord::Migration[5.1]
  def change
    add_column :offers, :social_until, :date
  end
end
