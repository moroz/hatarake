# frozen_string_literal: true

class MoveOfferLocationToTableLocations < ActiveRecord::Migration[5.0]
  def up
    execute('INSERT INTO locations (country_id, province_id, city, created_at, updated_at)
             SELECT country_id, province_id, location, NOW(), NOW() FROM offers')
    add_column :offers, :location_id, :integer
    execute('UPDATE offers AS o SET location_id = l.id FROM locations AS l WHERE
            o.country_id = l.country_id AND (o.province_id = l.province_id OR
            (o.province_id IS NULL AND l.province_id IS NULL)) AND (o.location = l.city OR
            (o.location IS NULL AND l.city IS NULL))')
    remove_column :offers, :location
    remove_column :offers, :province_id
    remove_column :offers, :country_id
    add_foreign_key :offers, :locations
  end

  def down
    add_column :offers, :location, :string
    add_reference :offers, :province
    add_reference :offers, :country
    execute('UPDATE offers AS o SET location = l.city, province_id = l.province_id,
            country_id = l.country_id FROM locations AS l WHERE l.id = o.location_id')
    remove_foreign_key :offers, :locations
    execute('DELETE FROM locations AS l USING offers AS o WHERE l.id = o.location_id')
    remove_column :offers, :location_id
  end
end
